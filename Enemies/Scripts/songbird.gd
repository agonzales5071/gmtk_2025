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
	if t < 1.0:
		t += delta / travel_time
		var nextPos = Math.GetParabolicPos(start_pos, target_pos, arc_height, t)
		rotation = nextPos.direction_to(position).angle()
		position = nextPos
		if start_pos.x < target_pos.x:
			animated_sprite.flip_h = true
			rotation += PI
	else:
		rotation = 0
		var direction = position.direction_to(player.position)
		if direction:
			if direction.x > 0:
				animated_sprite.flip_h = true
			else:
				animated_sprite.flip_h = false
		super._process(delta)
