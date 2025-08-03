extends CanvasLayer

@export var emptyIcon : Texture2D
@export var emptyText : String

@onready var new_weapons_ui = $WeaponMenuControl/VSplit/NewWeapons.get_children()
@onready var old_weapons_ui = $WeaponMenuControl/VSplit/CurrentWeapons.get_children()

@onready var weapon_cache: Node2D = %WeaponCache

var newWeapons : Array[Weapon]
var player : Player

func ShowMenu(weapons : Array[Weapon], player : Player) -> void:
	get_tree().paused = true
	visible = true
	self.player = player
	newWeapons = weapons
	for i in newWeapons.size():
		if (newWeapons[i]):
			new_weapons_ui[i].icon = newWeapons[i].thumbnail
			new_weapons_ui[i].text = newWeapons[i].name
			new_weapons_ui[i].weapon = newWeapons[i]
			new_weapons_ui[i].visible = true
		else:
			new_weapons_ui[i].visible = false
	for i in player.weapons.size():
		if player.weapons[i]:
			old_weapons_ui[i].icon = player.weapons[i].thumbnail
			old_weapons_ui[i].text = player.weapons[i].name
			old_weapons_ui[i].weapon = player.weapons[i]
		else:
			old_weapons_ui[i].icon = emptyIcon
			old_weapons_ui[i].text = emptyText
			old_weapons_ui[i].weapon = null

func _on_confirm_button_pressed() -> void:
	var selectedNew := new_weapons_ui[0].button_group.get_pressed_button() as WeaponButton
	var selectedOld := old_weapons_ui[0].button_group.get_pressed_button() as WeaponButton
	if selectedNew.weapon:
		player.GiveWeapon(selectedNew.weapon, selectedOld.idx)
	get_tree().paused = false
	visible = false


func _on_player_level_up(level, player : Player) -> void:
	self.player = player
	var weapons = weapon_cache.GetRandomWeapons(level)
	ShowMenu(weapons, player)
