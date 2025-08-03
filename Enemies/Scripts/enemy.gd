extends CharacterBody2D

class_name Enemy

@export var SPEED = 300.0
@export var damage = 20
@export var HP = 20
@export var InitialHP = HP
@onready var player = get_tree().get_nodes_in_group("Player")[0]
@onready var gm = get_tree().get_nodes_in_group("GameManager")[0]
@onready var animated_sprite = $AnimatedSprite2D

func GiveDamage() -> float:
	return damage

func TakeDamage(amount: float) -> void:
	HP -= amount
	if (HP <= 0):
		addToScore()
		queue_free()

func _process(delta: float) -> void:
	var direction = position.direction_to(player.position)
	if direction:
		velocity = direction * SPEED
		if direction.x > 0:
			animated_sprite.flip_h = true
		else:
			animated_sprite.flip_h = false
	move_and_slide()

func _physics_process(delta: float) -> void:
	pass

func addToScore() -> void:
	gm.increase_score(InitialHP)
