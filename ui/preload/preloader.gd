extends Control

const GODOT_INTRO:PackedScene = preload("res://ui/intros/godot_intro.tscn")

func _ready() -> void:
	await get_tree().create_timer(1).timeout
	load_next_scene()
	
	
func load_next_scene():
	var intro_scene = GODOT_INTRO
	get_tree().change_scene_to_packed(intro_scene)
	
