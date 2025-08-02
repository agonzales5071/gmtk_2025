extends Node2D

class_name Projectile

func GetNearestEnemy() -> Enemy:
	var enemies: Array[Node] = get_tree().get_nodes_in_group("Enemies")
	var nearestDist = INF
	var nearestEnemy : Enemy = null
	for enemy : Enemy in enemies:
		var dist = enemy.global_position.distance_squared_to(global_position)
		if dist < nearestDist:
			nearestEnemy = enemy
			nearestDist = dist
	return nearestEnemy

func GetEnemiesInRange(range : float) -> Array[Enemy]:
	var enemies: Array[Node] = get_tree().get_nodes_in_group("Enemies")
	var rangeSqr = range * range
	var enemiesInRange: Array[Enemy]
	for enemy : Enemy in enemies:
		var dist = enemy.global_position.distance_squared_to(global_position)
		if dist < rangeSqr:
			enemiesInRange.push_back(enemy)
	return enemiesInRange

func ProjectileInit(player : Player):
	assert(false, "Must Override ProjectileInit")
	pass
