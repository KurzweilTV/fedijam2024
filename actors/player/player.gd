extends CharacterBody2D

@export_category("Player Movement")
@export_range(100, 600, 5) var speed = 400.0
@export_range(-1000, -400, 10) var jump_power = -600.0
@export var total_jumps:int = 2
@export_range(0, 1, .1) var cowboy_timer:float = 0.2
@export var spawning:bool

@onready var animator: AnimationPlayer = $Animator

var jumps_remaining:int


func _ready() -> void:
	spawning = true
	jumps_remaining = total_jumps
	animator.play("spawn")

func _process(_delta: float) -> void:
	$DebugLabel.text = "Jumps: " + str(jumps_remaining) # Just for debug

func _physics_process(delta: float) -> void:
	if spawning:
		return
	if not is_on_floor(): # gravity and load the double jump
		add_gravity(delta)
	else:
		jumps_remaining = total_jumps

	if Input.is_action_just_pressed("jump") and jumps_remaining > 0:
		velocity.y = jump_power
		jumps_remaining -= 1
	elif Input.is_action_just_released("jump"): # allows short jumps if you let go
			if velocity.y <= 0:
				velocity.y = 0
			add_gravity(delta)
		
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide() #actually move

func add_gravity(delta) -> void:
	velocity += get_gravity() * delta
	
