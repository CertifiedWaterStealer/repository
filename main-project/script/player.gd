extends CharacterBody2D

var is_attacking: bool = false

var dash_cooldown_timer_is_ready: bool = true 

var movement = Vector2()

var stamina: int = 200
const STAMINA_DRAIN: int = 2
const STAMINA_MAX_VALUE: int = 0
const STAMINA_LOWEST_VALUE: int = 0
const STAMINA_REGEN: int = 2
var stamina_is_ready: bool = true

const SPEED = 300.0
const SPRINT_SPEED: float = 400.0
const WALK_SPEED: float = 300.0
const DASH_SPEED: float = 600.0

const ZERO_VELOCITY: float = 0
const JUMP_VELOCITY: float = -325.0
var double_jump: bool = true 

@export var stamina_ui: ProgressBar
@export var stamina_delay: Timer
@export var m1_timer: Timer
@export var dash_timer: Timer
@export var dash_cooldown: Timer
@export var animated_sprite: AnimatedSprite2D

func _ready():
	if not stamina_ui == null:
		stamina_ui.max_value = stamina
		stamina_ui.value = stamina

func _physics_process(delta: float) -> void:
	movement = Input.get_axis("a_key", "d_key")
	
	if movement:
		velocity.x = movement * SPEED
	else:
		velocity.x = lerp(velocity.x, 0.0, 0.2)
	
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

	
	if (Input.is_action_just_pressed("e_key") or Input.is_action_just_pressed("m1")) and not is_attacking:
		_slash()
	
	move_and_slide()

func _slash():
	var overlapping_collision_shapes = $AnimatedSprite2D/Area2D.get_overlapping_areas()
	for area in overlapping_collision_shapes:
		var parent = area.get_parent()
		parent.take_damage()
	is_attacking = true
	animated_sprite.play("slash")

func _stamina_delay_timeout() -> void:
	stamina_is_ready = true

func _on_dash_cooldown_timer_timeout() -> void:
	dash_cooldown_timer_is_ready = true

func _sprint():
	animated_sprite.play("sprint")

func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.animation == "slash":
		is_attacking = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if is_attacking and body.is_in_group("enemy"):
		print("hit")
