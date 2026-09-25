extends Area2D

var player: CharacterBody2D

var can_interact: bool = false

const value: int = 500

func _ready():
	for node in get_tree().get_nodes_in_group("Player"):
		player = node

func _process(_delta: float) -> void:
	_interact() 

func _interact():
	if Input.is_action_just_pressed("e_key") and can_interact == true:
		print(value)
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		can_interact = true
		print("has become true")
