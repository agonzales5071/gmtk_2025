extends BasicProjectile

class_name Thump

@export
var rangeMult = 1.0

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func ProjectileInit(player : Player) -> void:
	pass

func _process(delta: float) -> void:
	pass

func _on_timer_delete_timeout() -> void:
	queue_free()

func _on_timer_damage_timeout() -> void:
	var AOE := collision_shape_2d.shape as CircleShape2D
	var enemiesInRange := GetEnemiesInRange(AOE.radius * rangeMult)
	enemiesInRange.all(func (enemy) -> void: enemy.TakeDamage(damage))
