class_name enemy extends Area2D

@onready var attack_timer: Timer = $AttackTimer

@export var endpoint: Marker2D
@export var duration:float = 2.0
@export var wait_time:float = 1.0
@export_category("Boss")
@export var projectile:PackedScene = null
@export_range(0.1, 2, .1) var min_attack_speed = 0.1
@export_range(0.1, 2, .1) var max_attack_speed = 1.0

var start_position: Vector2
var end_position: Vector2 
var moving_to_end: bool = true

func _ready() -> void:
	randomize()
	if endpoint:
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



func fire_projectile() -> void:
	if projectile:
		attack_timer.wait_time = randf_range(min_attack_speed, max_attack_speed)
		var bolt_instance = projectile.instantiate()
		bolt_instance.global_position = global_position
		get_node("/root/LevelBase/Enemies").add_child(bolt_instance)
		attack_timer.start()
	else: return


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and body.has_method("die"):
		body.die()
