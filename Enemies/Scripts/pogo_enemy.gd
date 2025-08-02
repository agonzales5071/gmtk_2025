extends "res://Enemies/Scripts/enemy.gd"

@export var GRAVITY: float = 1000.0
@export var AIR_TIME: float = 1.5 # Duration of the arc
@export var APPROACH_MIN: float = 0.05
@export var APPROACH_MAX: float = 0.3
@export var APPROACH_DISTANCE: float = 400.0  # Max horizontal distance at which to scale


var vertical_velocity = 0.0
var bounce_timer = 0.0
var target_y: float  # Slowly updated toward player.y

func _ready():
	SPEED = 200.0
	target_y = position.y  # Start targeting current position
	

func _process(delta: float) -> void:
	bounce_timer -= delta

	var direction = position.direction_to(player.position)
	var horizontal_velocity = direction.x * SPEED

	if bounce_timer <= 0.0:
		# 1. Measure horizontal distance to player
		var dx = abs(player.position.x - position.x)

		# 2. Calculate dynamic approach factor based on dx
		var t = clamp(1.0 - (dx / APPROACH_DISTANCE), 0.0, 1.0)
		var approach_factor = lerp(APPROACH_MIN, APPROACH_MAX, t)

		# 3. Smoothly update target_y
		target_y = lerp(target_y, player.position.y, approach_factor)

		# 4. Compute jump velocity to hit target_y in air time
		var dy = target_y - position.y
		vertical_velocity = (dy - 0.5 * GRAVITY * AIR_TIME * AIR_TIME) / AIR_TIME

		bounce_timer = AIR_TIME

	# Apply gravity
	vertical_velocity += GRAVITY * delta

	velocity.x = horizontal_velocity
	velocity.y = vertical_velocity

	move_and_slide()
