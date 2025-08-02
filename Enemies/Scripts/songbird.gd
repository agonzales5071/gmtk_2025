extends "res://Enemies/Scripts/enemy.gd"

@export var peaked = false
@export var target_pos: Vector2 
@export var arc_height: float = 1000.0
@export var travel_time: float = 2  # seconds

var start_pos: Vector2
var t := 0.0

func _ready():
	start_pos = position
	target_pos = player.position
	SPEED = SPEED*2
	HP = HP/2
	
func _process(delta):
	var direction = position.direction_to(player.position)
	if direction:
		if direction.x > 0:
			animated_sprite.flip_h = true
		else:
			animated_sprite.flip_h = false
	if t < 1.0:
		t += delta / travel_time
		
		var x = lerp(start_pos.x, target_pos.x, t)

		# Parabolic arc:
		var y = lerp(start_pos.y, target_pos.y, t) - arc_height * 4 * t * (1 - t)

		position = Vector2(x, y)
	else:
		super._process(delta)
