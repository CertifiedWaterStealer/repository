extends CharacterBody2D

var stamina: int = 200
var speed = 300.0
const JUMP_VELOCITY = -325.0
var double_jump: bool = true 
var stamina_is_ready: bool = true

@export var stamina_ui: ProgressBar

func _ready():
	if not stamina_ui == null:
		stamina_ui.max_value = stamina
		stamina_ui.value = stamina

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	elif is_on_floor() and not double_jump:
		double_jump = true
		
	if Input.is_action_just_pressed("w_key"): 
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		elif double_jump:
			velocity.y = JUMP_VELOCITY
			double_jump = false
			
	# Handle jump.
	if Input.is_action_just_pressed("w_key") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("a_key", "d_key")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	if Input.is_action_pressed("shift"): 
		speed = 500.0
		stamina_ui.value = stamina
		if velocity.x != 0:
			stamina_is_ready = false
			stamina -= 2
			if stamina < 0:
				stamina = 0 
	elif stamina_is_ready:
		if stamina < 200:
			stamina += 2
			stamina_ui.value = stamina
			if stamina > 200:
				stamina = 200
				
	if Input.is_action_just_released("shift"):
		speed = 300.0
		$Timer.start()
		
	move_and_slide()

func _stamina_delay_timeout() -> void:
	stamina_is_ready = true
