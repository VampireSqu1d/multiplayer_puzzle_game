extends Node2D

@export var is_open: = false
@onready var door_closed: Sprite2D = $DoorClosed
@onready var door_open: Sprite2D = $DoorOpen








func _on_area_2d_area_entered(area: Area2D) -> void:
	if not multiplayer.is_server():
		return
	if is_open:
		return
	is_open = true
	area.get_owner().queue_free()
	set_door_properties()


func set_door_properties():
	door_open.visible = is_open
	door_closed.visible = !is_open


func _on_multiplayer_synchronizer_delta_synchronized() -> void:
	set_door_properties()
