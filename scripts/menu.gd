extends Node

@onready var ip_line_edit: LineEdit = %IPLineEdit
@onready var status_label: Label = %StatusLabel
@onready var level_holder: Node = %LevelHolder
@onready var not_connected_h_box: HBoxContainer = %NotConnectedHBox
@onready var host_hbox: HBoxContainer = %HostHbox
@onready var ui: Control = %UI

@export var level_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	multiplayer.connection_failed.connect(_on_connection_failed)
	multiplayer.connected_to_server.connect(_on_connected_to_server)


func _on_host_button_pressed() -> void:
	not_connected_h_box.hide()
	host_hbox.show()
	Lobby.create_game()
	status_label.text = "Hosting!"


func _on_start_button_pressed() -> void:
	hide_menu.rpc()
	change_level.call_deferred(level_scene)


func _on_join_button_pressed() -> void:
	not_connected_h_box.hide()
	Lobby.join_game(ip_line_edit.text)
	status_label.text = "Connecting..."


func change_level(scene: PackedScene):
	for c in level_holder.get_children():
		level_holder.remove_child(c)
		c.level_completed.disconnect(_on_level_completed)
		c.queue_free()
	var new_level = scene.instantiate()
	level_holder.add_child(new_level)
	new_level.level_completed.connect(_on_level_completed)

func _on_connection_failed():
	status_label.text = "Failed To Connect :C"
	not_connected_h_box.show()


func _on_connected_to_server():
	status_label.text = "Connected to Server, Yipee! c:"


@rpc("call_local", "authority", "reliable")
func hide_menu():
	ui.hide()


func _on_level_completed():
	call_deferred("change_level", level_scene)


