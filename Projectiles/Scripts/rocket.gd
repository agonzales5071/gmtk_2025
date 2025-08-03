extends BasicProjectile

@export
var rangeMult = 1.0

@onready var explosion_aoe: CollisionShape2D = $Explosion/ExplosionAOE
@onready var explosion_sprite: AnimatedSprite2D = $Explosion/ExplosionSprite
@onready var explosion: Node2D = $Explosion

var exploding = false

func ProjectileInit(player : Player) -> void:
	explosion.apply_scale(Vector2(rangeMult, rangeMult))
	super(player)

func _on_area_2d_body_entered(body: Node2D) -> void:
	var AOE := explosion_aoe.shape as CircleShape2D
	var enemiesInRange := GetEnemiesInRange(AOE.radius * rangeMult)
	enemiesInRange.all(func (enemy) -> void: enemy.TakeDamage(damage))
	exploding = true
	explosion_sprite.visible = true
	explosion_sprite.play()

func _process(delta: float) -> void:
	if !exploding:
		global_position += direction * delta

func _on_explosion_sprite_animation_finished() -> void:
	queue_free()
