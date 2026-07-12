extends Area2D

var player = CharacterBody2D
var damage: int = -1
var is_ready: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_slash") and is_ready:
		is_ready = false
		$Sword/Timer.start()
		print("action worked")


func _on_timer_timeout() -> void:
	is_ready = true
