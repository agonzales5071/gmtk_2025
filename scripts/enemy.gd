extends CharacterBody2D

class_name Enemy

@export var SPEED = 300.0
@export var damage = 20
@export var HP = 20
@onready var player = get_tree().get_nodes_in_group("Player")[0]

func GiveDamage() -> float:
	return damage

func TakeDamage(amount: float) -> void:
	HP -= amount
	if (HP <= 0):
		queue_free()

func _process(delta: float) -> void:
	var direction = position.direction_to(player.position)
	if direction:
		velocity = direction * SPEED
	move_and_slide()

func _physics_process(delta: float) -> void:
	pass
