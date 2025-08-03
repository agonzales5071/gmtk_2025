extends AnimatedSprite2D

class_name Weapon

@export
var projectile : PackedScene
@export
var thumbnail : Texture2D
@export
var weaponName : String = "Default Name"
@export
var audioChannel : AudioManager.Channel
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func Shoot() -> Node:
	var animation_name = "fire"
	if sprite_frames.has_animation(animation_name):
		print("Animation '" + animation_name + "' exists!")
		play(animation_name)
	else:
		print("noexist")
		
	return projectile.instantiate()


func _on_animation_finished() -> void:
	play("default")
	pass # Replace with function body.
