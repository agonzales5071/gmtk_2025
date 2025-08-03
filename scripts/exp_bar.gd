extends ProgressBar


@onready var player = get_tree().get_nodes_in_group("Player")[0]

func _ready():
	player.exp_up.connect(update)
	update()
	
func update():
	value = player.getEXP() 
	min_value = player.getLevel()*player.getLevel()
	max_value = player.getNextLevelEXP()
