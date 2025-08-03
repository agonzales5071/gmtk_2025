extends Node

@export var SpawnRate = 0.5
@export var SpawnRangeMax = 2000
@export var SpawnRangeMin = 1000
@export var enemies : Array[PackedScene]
@export var score = 0
@export var time = 0

var lastSpawn = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var timeInSec = Time.get_ticks_msec() / 1000.0
	var spawnIndex = floor(timeInSec / SpawnRate)
	if lastSpawn < spawnIndex:
		Spawn()
		lastSpawn = spawnIndex

func Spawn() -> void:
	var enemy : Enemy = enemies[randi_range(0, enemies.size() - 1)].instantiate()
	enemy.global_position = RandomPosAroundPlayer()
	%Enemies.add_child(enemy)

func RandomPosAroundPlayer() -> Vector2:
	var player : Player = %Player
	var randDist = randf_range(SpawnRangeMin, SpawnRangeMax)
	var randAng = randf_range(0, 2 * PI)
	return Vector2.from_angle(randAng) * randDist + player.global_position
	
func game_over():
	%ScoreTimer.stop()
	%HUD.show_game_over()

func new_game():
	score = 0
	time = 0
	%HUD.update_score_timer(score)
	%HUD.update_level(1)
	#%HUD.show_message("Get Ready")
	#$Player.start($StartPosition.position)
	%StartTimer.start()

func _on_start_timer_timeout() -> void:
	%ScoreTimer.start()

func _on_score_timer_timeout() -> void:
	time += 1
	%HUD.update_score_timer(time)
	
func increase_score(amount) -> void:
	score += amount
	%HUD.update_score(score)
