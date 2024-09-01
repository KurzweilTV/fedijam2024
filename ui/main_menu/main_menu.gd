extends Control

@onready var menu_animator: AnimationPlayer = $OptionsScreen/AnimationPlayer
@onready var click: AudioStreamPlayer = $MenuSounds/Click
@onready var hover: AudioStreamPlayer = $MenuSounds/Hover



func play_hover():
	hover.play()

func _on_start_button_pressed() -> void:
	pass
	
func _on_options_button_pressed() -> void:
	click.play()
	menu_animator.play("options_slide_in")

func _on_main_menu_button_pressed() -> void:
	click.play()
	menu_animator.play_backwards("options_slide_in")
