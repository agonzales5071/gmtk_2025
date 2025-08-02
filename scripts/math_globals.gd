extends RefCounted

class_name Math

static func GetParabolicPos(start_pos, target_pos, arc_height, t) -> Vector2:
	var x = lerp(start_pos.x, target_pos.x, t)
	# Parabolic arc:
	var y = lerp(start_pos.y, target_pos.y, t) - arc_height * 4 * t * (1 - t)
	return Vector2(x, y)
