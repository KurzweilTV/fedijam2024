extends Control

func unpause_game() -> void:
	get_tree().paused = false
	GameManager.game_paused = false
	queue_free()
	
func _unhandled_input(event: InputEvent) -> void:
	if(event.is_action_pressed("pause")):
		get_viewport().set_input_as_handled()
		unpause_game()

func _on_button_pressed() -> void:
	unpause_game()
