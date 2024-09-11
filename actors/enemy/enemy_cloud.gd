class_name enemy extends Area2D

@export var endpoint: Marker2D
@export var duration:float = 2.0
@export var wait_time:float = 1.0

var start_position: Vector2
var end_position: Vector2 
var moving_to_end: bool = true

func _ready() -> void:
	start_position = self.global_position
	end_position = endpoint.global_position
	start_tween()

func start_tween():
	var tween = create_tween()
	tween.set_loops().set_parallel(false)
	tween.tween_property(self, "position", end_position, duration / 2.0)
	tween.tween_property(self, "visible", true, wait_time) #HACK: Lazy way to make the platfrom wait
	tween.tween_property(self, "position", start_position, duration / 2.0)
	tween.tween_property(self, "visible", true, wait_time)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and body.has_method("die"):
		body.die()
