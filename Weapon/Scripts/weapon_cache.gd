extends Node2D

@onready var weapon_cache = get_children(false)

func GetRandomWeapons(level : float) -> Array[Weapon]:
	var newWeapons : Array[Weapon]
	for i in range(4):
		newWeapons.push_back(weapon_cache[randi_range(0, weapon_cache.size()-1)])
	return newWeapons
