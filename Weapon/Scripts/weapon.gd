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

var level
var buff = 0

var projectileRandomized : Projectile
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	projectileRandomized = projectile.instantiate()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func Shoot() -> Node:
	var animation_name = "fire"
	if sprite_frames.has_animation(animation_name):
		play(animation_name)
	var projectileRand = projectileRandomized.duplicate()
	(projectileRand as BasicProjectile).damage += buff
	return projectileRand


func _on_animation_finished() -> void:
	play("default")
	pass # Replace with function body.
	
func Randomize(level : int) -> void:
	self.level = level
	buff = randi_range(-1, level)
	if sign(buff) < 0:
		weaponName += " " + str(buff)
	else:
		weaponName += " +" + str(buff)
	pass
