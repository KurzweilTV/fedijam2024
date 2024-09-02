extends Control

@onready var menu_animator: AnimationPlayer = $OptionsScreen/AnimationPlayer
@onready var click: AudioStreamPlayer = $MenuSounds/Click
@onready var hover: AudioStreamPlayer = $MenuSounds/Hover

@export var first_level:PackedScene

func play_hover():
	hover.play()

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(first_level)
	
func _on_options_button_pressed() -> void:
	click.play()
	menu_animator.play("options_slide_in")

func _on_main_menu_button_pressed() -> void:
	click.play()
	menu_animator.play_backwards("options_slide_in")
