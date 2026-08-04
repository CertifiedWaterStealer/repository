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
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_slash") and is_ready:
		sword_animations.play("m1_animation")
		if sword_animations.animation_finished:
			pass
		is_ready = false
		sword_m1_cooldown.start()

func _on_timer_timeout() -> void:
	is_ready = true


func _on_body_entered(body: Node2D) -> void:
	if body is Enemy:
		body._take_damage(damage)
