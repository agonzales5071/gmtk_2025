extends Control

func _on_settings_button_pressed() -> void:
	pass # Replace with function body.
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().paused = true
		$CanvasLayer.visible = true

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_pause_button_pressed() -> void:
	get_tree().paused = false
	$CanvasLayer.visible = false
	pass # Replace with function body.
