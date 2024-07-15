extends Node2D


@onready var door_closed: Sprite2D = $DoorClosed
@onready var door_open: Sprite2D = $DoorOpen
@onready var collision_shape_2d: CollisionShape2D = $DoorClosed/StaticBody2D/CollisionShape2D
@export var is_open: = false


func activate(state: bool):
	if not multiplayer.is_server():
		return
	is_open = state
	set_door_properties()



func set_door_properties():
	door_open.visible = is_open
	door_closed.visible = !is_open
	collision_shape_2d.set_deferred("disabled", is_open)



func _on_multiplayer_synchronizer_delta_synchronized() -> void:
	set_door_properties()
