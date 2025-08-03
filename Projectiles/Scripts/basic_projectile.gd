extends Projectile

class_name BasicProjectile

@onready var player = get_tree().get_nodes_in_group("Player")[0]

@export
var SPEED = 1500.0
@export
var damage = 20

var direction : Vector2

#RNG for Damage variation
var rng = RandomNumberGenerator.new()

func ProjectileInit(player : Player) -> void:
	# Don't inherit player properties since that'd make projectiles
	# follow the player
	top_level = true
	
	global_position = (get_parent() as Node2D).global_position
	var nearestEnemy = GetNearestEnemy()
	if nearestEnemy:
		direction = global_position.direction_to(nearestEnemy.global_position)
	else:
		direction = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)).normalized()
	global_rotation = direction.angle()
	direction *= SPEED

func damageVariation():
	var currLevel = player.getLevel()
	#RNG range is a minimum -1 base damge and a maximum of base damage + current level. To cbalance
	var finalDamage = damage + rng.randi_range(-1, currLevel)
	return finalDamage

func _process(delta: float) -> void:
	global_position += direction * delta

func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body is Enemy):
		var enemy = body as Enemy
		#calculate damage to do on hit
		var finalDamage = damageVariation()
		#for debugging to verify range is currect
		print(finalDamage)
		enemy.TakeDamage(finalDamage)
	queue_free()
