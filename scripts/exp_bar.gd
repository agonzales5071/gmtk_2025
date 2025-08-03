extends ProgressBar


@onready var player = get_tree().get_nodes_in_group("Player")[0]

#func _ready():
	#player.exp_up.connect(update)
	#update()
	#
#func update():
	#var currentLevelEXP = player.getLevelEXP()
	#var expOverLevel = player.getEXP() - currentLevelEXP
	#if(player.getNextLevelEXP() != 0):
		#var percentage = expOverLevel/(player.getNextLevelEXP()-currentLevelEXP)
		#print("currentlevelexp = " + currentLevelEXP)
		#print("nextlevel = " + str(player.getNextLevelEXP()))
		#
		#print("calc = " + str(percentage))
		#value = percentage
		
