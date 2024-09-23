extends Control

@onready var menu_animator: AnimationPlayer = $OptionsScreen/AnimationPlayer
@onready var click: AudioStreamPlayer = $MenuSounds/Click
@onready var hover: AudioStreamPlayer = $MenuSounds/Hover
@onready var fader: AnimationPlayer = $Fader/AnimationPlayer

@export var first_level:PackedScene = preload("res://scenes/levels/level_1.tscn")

func play_hover():
	hover.play()

func _on_start_button_pressed() -> void:
	fader.play_backwards("fade_animation")
	await fader.animation_finished
	get_tree().change_scene_to_packed(first_level)
	
func _on_options_button_pressed() -> void:
	click.play()
	menu_animator.play("options_slide_in")

func _on_main_menu_button_pressed() -> void:
	click.play()
	menu_animator.play_backwards("options_slide_in")
