extends Area2D

@export var water_value:int = 10

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Player.water += water_value
		queue_free()
		
