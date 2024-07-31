extends Node
class_name HelperFunctions

static func client_interpolate(global_pos, target_pos, delta, lerp_sync_speed = 25):
	if target_pos == Vector2.INF:
		return global_pos
	
	if (global_pos - target_pos).length_squared() > 100 * 100:
		return target_pos
	
	return lerp(target_pos, global_pos, pow(0.5, delta * lerp_sync_speed))
