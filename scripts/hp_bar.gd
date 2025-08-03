extends ProgressBar


@onready var player = get_tree().get_nodes_in_group("Player")[0]

func _ready():
	player.hit.connect(update)
	update()
	
func update():
	value = player.GetHP() 
