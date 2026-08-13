extends CharacterBody2D

var sword_timer_is_ready: bool = true
var sword_animation = AnimationPlayer
var dash_cooldown_timer_is_ready: bool = true 

var stamina: int = 200
const STAMINA_DRAIN: int = 2
const STAMINA_MAX_VALUE: int = 0
const STAMINA_LOWEST_VALUE: int = 0
const STAMINA_REGEN: int = 2
var stamina_is_ready: bool = true

var speed = 300.0
const SPRINT_SPEED: float = 400.0
const WALK_SPEED: float = 300.0
const DASH_SPEED: float = 600.0

const ZERO_VELOCITY: float = 0
const JUMP_VELOCITY: float = -325.0
var double_jump: bool = true 

@export var stamina_ui: ProgressBar
@export var stamina_delay: Timer
@export var character: Node2D
@export var sword: Area2D
@export var m1_timer: Timer
@export var dash_timer: Timer
@export var dash_cooldown: Timer

func _ready():
	if not stamina_ui == null:
		stamina_ui.max_value = stamina
		stamina_ui.value = stamina
		sword_animation = sword.sword_animations

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
		character.scale.x = -1 if direction < 0 else 1
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	if Input.is_action_just_pressed("dash") and dash_cooldown_timer_is_ready:
		dash_cooldown_timer_is_ready = false
		_dash()
		dash_cooldown.start()

	if Input.is_action_pressed("shift"): 
		speed = SPRINT_SPEED
		stamina_ui.value = stamina
		if velocity.x != ZERO_VELOCITY:
			stamina_is_ready = false
			stamina -= STAMINA_DRAIN
			if stamina < 0:
				stamina = STAMINA_MAX_VALUE
				if stamina == STAMINA_LOWEST_VALUE:
					speed = WALK_SPEED
	elif stamina_is_ready == true:
		if stamina < 200:
			stamina += STAMINA_REGEN
			stamina_ui.value = stamina
			if stamina > 200:
				stamina = STAMINA_MAX_VALUE
				
	if Input.is_action_just_released("shift"):
		speed = WALK_SPEED
		stamina_delay.start()
	
	if (Input.is_action_just_pressed("e_key") or Input.is_action_just_pressed("m1")) and sword_timer_is_ready:
		sword_timer_is_ready = false
		_m1()
		m1_timer.start()
	
	move_and_slide()

func _stamina_delay_timeout() -> void:
	stamina_is_ready = true

func _sword_m1_timer_timeout() -> void:
	sword_timer_is_ready = true

func _m1():
	sword_animation.play("m1_animation")

func _on_dash_runtime_timeout() -> void:
	speed = WALK_SPEED

func _on_dash_cooldown_timer_timeout() -> void:
	dash_cooldown_timer_is_ready = true

func _dash() -> void:
	dash_timer.start()
	speed = DASH_SPEED
