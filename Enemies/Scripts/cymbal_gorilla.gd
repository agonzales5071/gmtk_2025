extends "res://Enemies/Scripts/enemy.gd"

func _ready():
	SPEED = SPEED/2
	HP = HP*4
	
func _process(delta: float) -> void:
	super._process(delta)
