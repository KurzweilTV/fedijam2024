extends CharacterBody2D

@export_category("Player Movement")
@export_range(100, 600, 5) var speed = 400.0
@export_range(-1000, -400, 10) var jump_power = -650.0
@export var total_jumps:int = 2
@export_range(0, 1, .1) var cowboy_timer:float = 0.2
@export var spawning:bool
@export_category("Water Usage")
@export var cost_to_jump:int = 2

@onready var effect_animator: AnimationPlayer = %Animator
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var char_animator: AnimationPlayer = $CharAnimator
@onready var float_effect: GPUParticles2D = %FloatEffect
@onready var jump_effect:PackedScene = preload("res://actors/player/jump_effect.tscn")
@onready var camera: Camera2D = $Camera2D

var jumps_remaining:int

func _ready() -> void:
	spawning = true
	jumps_remaining = total_jumps
	effect_animator.play("spawn")
	camera.enabled = true

# DEBUG FUNCTION
func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("debug_respawn"):
		Messages.spawn_player.emit()
		queue_free()

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
	if Input.is_action_pressed("jump") and velocity.y > 0: #floating
		Player.water -= delta * 2
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

func add_gravity(delta) -> void:
	velocity += get_gravity() * delta
