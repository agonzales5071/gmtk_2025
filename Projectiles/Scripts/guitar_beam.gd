extends BasicProjectile
@onready var area_2d: Area2D = $Node2D/Area2D
@onready var collision_shape_2d: CollisionShape2D = $Node2D/Area2D/CollisionShape2D

func _process(delta: float) -> void:
	pass

func _on_area_2d_body_entered(body : Node2D) -> void:
	if body is Enemy:
		body.TakeDamage(damage)

func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
