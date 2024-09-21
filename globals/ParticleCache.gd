extends CanvasLayer

const CHECKPOINT_STARS = preload("res://particles/CheckpointStars.tres")
const DEATH_EFFECT = preload("res://particles/DeathEffect.tres")
const WIND = preload("res://particles/wind.tres")

var materials = [
	CHECKPOINT_STARS,
	DEATH_EFFECT,
	WIND,
]

func _ready() -> void:
	for material in materials:
		var particle_instance = GPUParticles2D.new()
		particle_instance.process_material = material
		particle_instance.one_shot = true
		particle_instance.modulate = Color(1,1,1,0)
		particle_instance.lifetime = 0.1
		particle_instance.emitting = true
		self.add_child(particle_instance)
