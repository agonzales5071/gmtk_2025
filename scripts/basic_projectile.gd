extends Projectile

class_name BasicProjectile

@export
var SPEED = 1500.0
@export
var damage = 20

var direction : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var nearestEnemy = GetNearestEnemy()
	if nearestEnemy:
		direction = global_position.direction_to(nearestEnemy.global_position)
	else:
		direction = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)).normalized()
	global_rotation = direction.angle()
	direction *= SPEED

func _process(delta: float) -> void:
	global_position += direction * delta
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body is Enemy):
		var enemy = body as Enemy
		enemy.TakeDamage(damage)
	queue_free()
