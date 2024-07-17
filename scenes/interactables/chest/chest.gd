extends Node2D


@onready var chest_locked: Sprite2D = $ChestLocked
@onready var chest_unlocked: Sprite2D = $ChestUnlocked
@export var key_scene: PackedScene
@onready var key_spawn: Node2D = $KeySpawn

@export var is_locked: = true




func _on_interactible_interacted():
	if is_locked:
		is_locked = false
		var key = key_scene.instantiate()
		key_spawn.add_child(key)
		set_chest_properties()


func set_chest_properties():
	chest_locked.visible = is_locked
	chest_unlocked.visible = !is_locked


func _on_multiplayer_synchronizer_delta_synchronized() -> void:
	set_chest_properties()
