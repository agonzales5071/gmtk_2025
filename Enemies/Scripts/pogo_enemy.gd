extends Enemy

@export var AIR_HEIGHT: float = 200
var startPos : Vector2
var endPos : Vector2
@export var maxDistJump : float = 2000
var time_in_flight : SceneTreeTimer
var airTime

func _ready() -> void:
	UpdateTarget()
	super()

func UpdateTarget() -> void:
	startPos = global_position
	var distJump = min(maxDistJump, startPos.distance_to(player.global_position))
	endPos = startPos + startPos.direction_to(player.global_position) * distJump
	airTime = startPos.distance_to(endPos)/SPEED
	time_in_flight = get_tree().create_timer(airTime)
	time_in_flight.timeout.connect(UpdateTarget)

func _process(delta: float) -> void:
	if time_in_flight:
		var timePos = (airTime - time_in_flight.time_left)\
						/ airTime
		position = Math.GetParabolicPos(startPos, endPos, AIR_HEIGHT, timePos)
	move_and_slide()
