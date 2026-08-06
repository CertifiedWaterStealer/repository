extends Area2D

var player = CharacterBody2D
var damage: int = 2
var is_ready: bool = true

@export var sword_animations: AnimationPlayer
@export var sword_m1_cooldown: Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("E_key") and is_ready:
		is_ready = false
		_slash()
		sword_m1_cooldown.start()

func _on_timer_timeout() -> void:
	is_ready = true

func _on_body_entered(body: Node2D) -> void:
	if body is Enemy:
		body._take_damage(damage)

func _slash() -> void:
		sword_animations.play("m1_animation")
		if sword_animations.animation_finished:
			pass
