extends CharacterBody2D

class_name Enemy

@export var SPEED = 300.0
@export var damage = 20
@export var HP = 20
var InitialHP = HP
@onready var player = get_tree().get_nodes_in_group("Player")[0]
@onready var gm = get_tree().get_nodes_in_group("GameManager")[0]
@onready var animated_sprite = $AnimatedSprite2D
@onready var health_bar: ProgressBar = $ProgressBar
var heal_bar_visible : int = 0
const heal_bar_time = 1.0

var speedDownMultiplier := 1.0
var speedDownTimer : SceneTreeTimer

func GiveDamage() -> float:
	return damage

func TakeDamage(amount: float) -> void:
	HP -= amount
	health_bar.value = HP
	heal_bar_visible += 1
	get_tree().create_timer(heal_bar_time, false).timeout.connect(\
		func() -> void: heal_bar_visible-= 1)
	if (HP <= 0):
		addToScore()
		addToEXP()
		queue_free()

func GetSpeed() -> float:
	return SPEED * min(speedDownMultiplier, 5)

func _ready() -> void:
	health_bar.min_value = 0
	health_bar.max_value = HP

func _process(delta: float) -> void:
	health_bar.visible = heal_bar_visible > 0
	var direction = position.direction_to(player.position)
	if direction:
		velocity = direction * GetSpeed()
		if direction.x > 0:
			animated_sprite.flip_h = true
		else:
			animated_sprite.flip_h = false
	move_and_slide()

func _physics_process(delta: float) -> void:
	pass

func addToScore() -> void:
	gm.increase_score(InitialHP)

func addToEXP() -> void:
	player.addEXP()

func GiveSlow(multiplier : float, time : float) -> void:
	speedDownMultiplier *= multiplier
	get_tree().create_timer(time, false).timeout.connect(\
		func() -> void: speedDownMultiplier /= multiplier)
