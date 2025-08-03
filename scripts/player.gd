extends CharacterBody2D

class_name Player

signal hit
signal level_up(level : float, player : Player)
signal exp_up

@export_range(0, 1500000, 10000, "or_greater")
var SPEED = 1500.0

@export_range(1, 100, 1, "or_greater")
var HP = 100

@export
var weapons : Array[Weapon] = [null, null, null, null]
@onready
var weaponsPlacement: Array[Node2D] = [$Slot0, $Slot1, $Slot2, $Slot3]
@onready var audio_manager: AudioManager = $AudioManager

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var maxHP = HP
@onready var level = 1
@onready var exp = 0

@export
var timeToShot = 0.5
var lastShot : int = 0
var invincible = false

func GiveWeapon(weapon : Weapon, slot : int) -> void:
	assert(slot < 4)
	var oldWeapon = weaponsPlacement[slot].get_children()
	if oldWeapon:
		weaponsPlacement[slot].remove_child(oldWeapon[0])
	var dupeWeapon = weapon.duplicate()
	weaponsPlacement[slot].add_child(dupeWeapon)
	weapons[slot] = dupeWeapon
	audio_manager.UpdateForWeapons(weapons)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var randomStarters = %WeaponCache.GetRandomWeapons(1)
	GiveWeapon(randomStarters[0], 1);
	GiveWeapon(randomStarters[1], 2);
	pass
	
func level_up_player() -> void:
	#callLevelUpMenu
	level += 1
	level_up.emit(level, self)
	pass
	
func addEXP() -> void:
	exp += 1
	exp_up.emit()
	if(exp == getNextLevelEXP()): #exponential leveling
		level_up_player()

func _process(delta: float) -> void:
	if IsDead():
		return
	Move()
	CheckShoot()

func Move() -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("input_left", "input_right", "input_up", "input_down")
	if direction:
		velocity = direction * SPEED
		if direction.x > 0:
			animated_sprite_2d.play("walking")
			animated_sprite_2d.flip_h = false
		elif direction.x < 0:
			animated_sprite_2d.play("walking")
			animated_sprite_2d.flip_h = true
		if(velocity.x == 0):
			animated_sprite_2d.play("default")
			
			
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	move_and_slide()

func CheckShoot() -> void:
	var timeInSec = Time.get_ticks_msec() / 1000.0
	var shotIndex : int = timeInSec / timeToShot
	if shotIndex > lastShot:
		var weapon := weapons[shotIndex % weapons.size()]
		lastShot = shotIndex
		if weapon:
			var projectile := weapon.Shoot()
			weaponsPlacement[shotIndex % weapons.size()].add_child(projectile)
			projectile.ProjectileInit(self)

func _on_hurtbox_body_entered(body: Node2D) -> void:
	if (IsDead()):
		return
	if (body is Enemy):
		var enemy = body as Enemy
		if (!invincible):
			HP -= enemy.GiveDamage()
			hit.emit()
			if HP <= 0:
				$AudioManager.play_sound_effect("death")
				animated_sprite_2d.visible = false
				await get_tree().create_timer(3.0).timeout
				get_tree().reload_current_scene()

func GetMaxHP() -> int:
	return maxHP
func GetHP() -> int:
	return HP

func getLevel() -> int:
	return level

func getEXP() -> int:
	return exp
	
func getLevelEXP() -> int:
	return pow(level, 2)

func getNextLevelEXP() -> int:
	return pow(level + 1, 2)

func IsDead() -> bool:
	return HP <= 0
