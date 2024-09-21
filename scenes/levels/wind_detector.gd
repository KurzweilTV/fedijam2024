extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.enter_wind()


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.exit_wind()
