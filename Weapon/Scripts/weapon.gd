extends AnimatedSprite2D

class_name Weapon

@export
var projectile : PackedScene
@export
var thumbnail : Texture2D
@export
var weaponName : String = "Default Name"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func Shoot() -> Node:
	return projectile.instantiate()
