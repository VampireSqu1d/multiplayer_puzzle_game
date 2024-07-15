extends Node2D


@onready var chest_locked: Sprite2D = $ChestLocked
@onready var chest_unlocked: Sprite2D = $ChestUnlocked
@export var is_locked: = true


func _on_test_interact(state):
	if state:
		_on_interactible_interacted()

func _on_interactible_interacted():
	if is_locked:
		is_locked = false
		set_chest_properties()


func set_chest_properties():
	chest_locked.visible = is_locked
	chest_unlocked.visible = !is_locked


func _on_multiplayer_synchronizer_delta_synchronized() -> void:
	set_chest_properties()
