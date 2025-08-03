extends BasicProjectile

@export var arcHeight : float = 400
@export var timeSplat : float = 2
@export var slowDuration : float = 1.0

var startPos : Vector2
var endPos : Vector2
var time_in_flight : SceneTreeTimer
var time_to_splat : float
@onready var area_2d: Area2D = $Area2D
@onready var goo_projectile: Sprite2D = $GooProjectile
@onready var goo_splat: AnimatedSprite2D = $GooSplat

func ProjectileInit(player : Player) -> void:
	# Don't inherit player properties since that'd make projectiles
	# follow the player
	top_level = true
	
	global_position = (get_parent() as Node2D).global_position
	
	startPos = global_position
	
	var nearestEnemy = GetNearestEnemy()
	if nearestEnemy:
		endPos = nearestEnemy.global_position
	else:
		endPos = Vector2(randf_range(-1000.0, 1000.0), randf_range(-1000.0, 1000.0)) + startPos
	global_rotation = direction.angle()
	time_to_splat = startPos.distance_to(endPos) / SPEED
	time_in_flight = get_tree().create_timer(time_to_splat, false)
	time_in_flight.timeout.connect(OnTimeout)

func _process(delta: float) -> void:
	if time_in_flight:
		var timePos = (time_to_splat - time_in_flight.time_left)\
						/ time_to_splat
		position = Math.GetParabolicPos(startPos, endPos, arcHeight, timePos)

func OnTimeout() -> void:
	goo_projectile.visible = false
	goo_splat.visible = true
	var bodies = area_2d.get_overlapping_bodies()
	for body in bodies:
		if body is Enemy:
			body.GiveSlow(slowAmount, slowDuration)
	get_tree().create_timer(timeSplat, false).timeout.connect(func() -> void: queue_free())
