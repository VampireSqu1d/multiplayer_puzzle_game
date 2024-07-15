extends Area2D

signal interacted()

@export var collision_shape: CollisionShape2D


@rpc("any_peer", "call_local", "reliable")
func interact():
	if multiplayer.is_server():
		interacted.emit()





