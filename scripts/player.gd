extends CharacterBody2D

class_name Player

signal hit

@export_range(0, 1500000, 10000, "or_greater")
var SPEED = 1500.0

@export_range(1, 100, 1, "or_greater")
var HP = 100

@export
var weapons : Array[Weapon] = [null, null, null, null]
@onready
var weaponsPlacement: Array[Node2D] = [$Slot0, $Slot1, $Slot2, $Slot3]

@export
var timeToShot = 0.5
var lastShot : int = 0
var invincible = false

@onready var weapon_cache = %WeaponCache.get_children(false)

func GiveWeapon(weapon : Weapon, slot : int) -> void:
	weapons[slot] = weapon.duplicate()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _process(delta: float) -> void:
	Move()
	CheckShoot()

func Move() -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction:
		velocity = direction * SPEED
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
	if (body is Enemy):
		hit.emit()
		var enemy = body as Enemy
		if (!invincible):
			HP -= enemy.GiveDamage()
			print("HP: ", HP)
			if HP <= 0:
				print("DED")
				$AudioManager.play_sound_effect("death")
				get_tree().reload_current_scene()
