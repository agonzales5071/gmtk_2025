extends BasicProjectile

@export var scaleFactor : float = 3
@export var timeToFly : float = 5
@onready var originalScale : Vector2 = scale

func ProjectileInit(player : Player) -> void:
	# Don't inherit player properties since that'd make projectiles
	# follow the player
	top_level = true
	global_position = (get_parent() as Node2D).global_position
	var nearestEnemy = GetNearestEnemy()
	direction = global_position.direction_to(nearestEnemy.global_position)
	global_rotation = direction.angle()
	get_tree().create_timer(timeToFly).timeout.connect(func() -> void: queue_free())

func _process(delta: float) -> void:
	global_position += direction * SPEED * delta
	scale += Vector2(delta * scaleFactor, delta * scaleFactor)

func _on_area_2d_body_entered(body : Node2D) -> void:
	if body is Enemy:
		body.TakeDamage(damage)
