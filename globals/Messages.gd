extends Node

signal spawn_player

const MESSAGE_SCENE = preload("res://ui/popups/message_box.tscn")


func load_popup(message):
	var popup_instance = MESSAGE_SCENE.instantiate()
	popup_instance.message = message
	add_child(popup_instance)
	get_tree().paused = true
