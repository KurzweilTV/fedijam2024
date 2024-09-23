class_name projectile
extends Area2D

@onready var sprite: Sprite2D = $Sprite2D

var projectile_speed = 5

func _process(delta: float) -> void:
	rotation_degrees += (360 * delta)
	position.x -= projectile_speed

func _on_timer_timeout() -> void:
	self.queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("die"):
		body.die()
