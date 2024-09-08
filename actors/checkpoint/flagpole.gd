extends Area2D

var spawn_point:Marker2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D

var active:bool = false

func _ready() -> void:
	spawn_point = get_tree().get_nodes_in_group("spawn")[0] as Marker2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and not active:
		animated_sprite_2d.play()
		active = true
		spawn_point.global_position = global_position
		gpu_particles_2d.emitting = true
