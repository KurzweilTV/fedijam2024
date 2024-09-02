extends Node

var pause_scene:PackedScene = load("res://ui/pause_menu/pause_menu.tscn")
var game_paused:bool = false

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause") and not game_paused:
		pause_game()

func pause_game() -> void:
	var pause_screen = pause_scene.instantiate()
	add_child(pause_screen)
	game_paused = true
	get_tree().paused = true
