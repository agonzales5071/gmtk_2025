extends Enemy

class_name Elephant

@export var speedMultipler : float = 3.0
@onready var area_2d: Area2D = $Area2D
@export var speedTime : float = 1.0
@onready var attack_anim: AnimatedSprite2D = $AttackAnim

func _ready() -> void:
	super()

func _process(delta: float) -> void:
	super(delta)

func _on_speed_up_timer_timeout() -> void:
	var overlapping = area_2d.get_overlapping_bodies()
	for body in overlapping:
		if body is Enemy and body is not Elephant:
			body.GiveSlow(speedMultipler, speedTime)
	attack_anim.visible = true
	attack_anim.play()


func _on_attack_anim_animation_finished() -> void:
	attack_anim.visible = false
