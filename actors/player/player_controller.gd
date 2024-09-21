extends CharacterBody2D

@export_category("Player Movement")
@export_range(100, 600, 5) var speed = 400.0
@export_range(-1000, -400, 10) var jump_power = -650.0
@export var total_jumps:int = 2
@export_category("Water Usage")
@export var cost_to_jump:int = 2
@export var cost_to_float:int = 2 #this is a multiplier of delta

@onready var effect_animator: AnimationPlayer = %Animator
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var char_animator: AnimationPlayer = $CharAnimator
@onready var float_effect: GPUParticles2D = %FloatEffect
@onready var jump_effect:PackedScene = preload("res://actors/player/jump_effect.tscn")
@onready var always_effect: GPUParticles2D = %"Always Effects"
@onready var camera: Camera2D = $Camera2D
@onready var death_effect: GPUParticles2D = $Effects/DeathEffect

var jumps_remaining:int
var spawning:bool
var is_in_wind:bool

func _ready() -> void:
	get_tree().paused = false
	spawning = true
	jumps_remaining = total_jumps
	effect_animator.play("spawn")
	camera.enabled = true
	Player.water = Player.starting_water

# DEBUG FUNCTION
func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("debug_respawn"):
		die()

func _physics_process(delta: float) -> void:
	if spawning:
		return
	if not is_on_floor(): # gravity and load the double jump
		add_gravity(delta)
	else:
		jumps_remaining = total_jumps

	if Input.is_action_just_pressed("jump") and jumps_remaining > 0:
		if able_to_jump():
			spawn_jump_effect()
			velocity.y = jump_power
			jumps_remaining -= 1		
	elif Input.is_action_just_released("jump"): # allows short jumps if you let go
			if velocity.y <= 0:
				velocity.y = 0
			add_gravity(delta )
		
	# Slow fall when holding jump and falling
	if Input.is_action_pressed("jump") and velocity.y > 0 and able_to_jump(): #floating
		Player.water -= delta * cost_to_float
		velocity.y = lerp(velocity.y, 50.0, delta * 5)
		float_effect.emitting = true
	else:
		float_effect.emitting = false

	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		char_animator.play("walk")
		sprite_2d.frame = 1
		velocity.x = direction * speed
		if direction < 0:
			sprite_2d.flip_h = true
		else:
			sprite_2d.flip_h = false
	else:
		sprite_2d.frame = 0
		char_animator.play("idle")
		velocity.x = move_toward(velocity.x, 0, speed)

	if velocity.y < 0:
		sprite_2d.frame = 2
	elif velocity.y > 0:
		sprite_2d.frame = 3

	move_and_slide() #actually move

func die() -> void:
	death_effect.emitting = true
	always_effect.emitting = false
	sprite_2d.hide()
	spawning = true
	await get_tree().create_timer(death_effect.lifetime).timeout
	Messages.spawn_player.emit()
	queue_free()
	
func spawn_jump_effect() -> void:
	Player.water -= cost_to_jump
	var effect = jump_effect.instantiate()
	effect.position = global_position
	get_parent().add_child(effect)
	await get_tree().create_timer(3).timeout
	get_parent().remove_child(effect)
	effect.queue_free()

func able_to_jump() -> bool:
	if Player.water - cost_to_jump >= 0:
		return true
	else: return false

func enter_wind() -> void:
	is_in_wind = true
	
func exit_wind() -> void:
	is_in_wind = false
	

func add_gravity(delta) -> void:
	if is_in_wind:
		velocity -= (get_gravity() * delta) / 2
	else:
		velocity += get_gravity() * delta
