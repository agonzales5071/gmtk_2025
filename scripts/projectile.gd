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
