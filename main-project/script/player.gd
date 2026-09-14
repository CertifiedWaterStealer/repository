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

const GRAVITY: float = 600.0

const JUMP_SPEED: float = 170.0
const JUMP_ACCELERATION: float = 400.0
var total_jumps: int = 2 

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

# This runs repeatidly, handling the physics and physics related functions. 'delta' 
# is the time since the previous frame. I multiply my 'GRAVITY' constant with my 
# 'delta' perameter. 'velocity.y' is a 'Vector2' in the y axis. So summarised, 
# I am multiplying my 'GRAVITY' constant with my delta parameter, then plusing this 
# with 'velocity.y'. 
func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta
	_horizontal_movement()
	_jump()
	_wall_slide()
	_animations()
	_animation_flip()
	move_and_slide()

func _horizontal_movement():
	movement = Input.get_axis("a_key", "d_key")
	if movement:
		velocity.x = movement * SPEED
	else:
		velocity.x = lerp(velocity.x, 0.0, 0.2)

	if (Input.is_action_just_pressed("e_key") or Input.is_action_just_pressed("m1")) and not is_attacking:
		_slash()

# Handles the character's jump. This first section checks if the player is on the floor.
# If they are, then the player is capable of jumping. 
func _jump():
	if is_on_floor():
		total_jumps = 2
		if Input.is_action_just_pressed("w_key"):
			total_jumps -= 1 
			velocity.y -= lerp(JUMP_SPEED, JUMP_ACCELERATION, 0.1)

# This second part of the jump function, handles the player's double jumpimg ability.
# If the player is not on the floor, then they can jump.  
	if not is_on_floor():
		if total_jumps > 0:
			if Input.is_action_just_pressed("w_key"):
				total_jumps -= 1
				velocity.y -= lerp(JUMP_SPEED, JUMP_ACCELERATION, 0.1)
	else:
		return

func _wall_slide():
	if is_on_wall_only():
		velocity.y = 10 

func _animations():
	if velocity.x != 0: 
		animated_sprite.play("walk")
	if velocity.x == 0:
		animated_sprite.play("idle")

func _animation_flip():
	if velocity.x > 0:
		animated_sprite.flip_h = false
	if velocity.x < 0:
		animated_sprite.flip_h = true

func _slash():
	var overlapping_collision_shapes = $AnimatedSprite2D/Area2D.get_overlapping_areas()
	for area in overlapping_collision_shapes:
		var parent = area.get_parent()
		parent.take_damage()
	is_attacking = true
	animated_sprite.play("slash")

func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.animation == "slash":
		is_attacking = false
