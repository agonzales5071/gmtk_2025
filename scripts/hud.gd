extends CanvasLayer

# Notifies `Main` node that the button has been pressed
signal start_game
# Called when the node enters the scene tree for the first time.
@onready var player = get_tree().get_nodes_in_group("Player")[0]

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()
	
func show_game_over():
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	#await $MessageTimer.timeout
	#$Message.text = "Dodge the Creeps!"
	#$Message.show()
	
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0, false).timeout
	$StartButton.show()
	
func update_score(score):
	$ScoreLabel.text = "Score: " + str(score)
	
func update_level(level, player : Player):
	$EXPBar/LevelLabel.text = "Level " + str(level)
	
func update_score_timer(time):
	var sec = time % 60
	var secStr = str(getTwoDigitFloatAsString(sec))
	var min = round((time/60)%60)
	var minStr = str(getTwoDigitFloatAsString(min))
	var hour = int(time/3600)
	$TimerLabel.text = "Time: " + str(hour) + ":" + minStr + ":" + secStr
	
func getTwoDigitFloatAsString(time : float) -> String:
	var ones_digit = int(time) % 10
	var tens_digit = (int(time) / 10) % 10
	return str(tens_digit) + str(ones_digit)
	
	
func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()

func _on_message_timer_timeout():
	$Message.hide()

func _ready():
	
	player.level_up.connect(update_level)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
