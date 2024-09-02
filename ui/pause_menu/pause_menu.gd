extends Control

func unpause_game() -> void:
	GameManager.game_paused = false
	get_tree().paused = false
	call_deferred("queue_free")

func _input(event: InputEvent):
	if(event.is_action_pressed("Pause")):
		unpause_game()

func _on_button_pressed() -> void:
	unpause_game()
