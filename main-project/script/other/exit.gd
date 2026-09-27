extends Area2D

# Specifying the variables type.
var player: CharacterBody2D

# Can interact intialy will equal to false.
var can_interact: bool = false

# When this start, find every node in player the "Player" group and store it into a variable.
func _ready():
	for node in get_tree().get_nodes_in_group("Player"):
		player = node

# Will constantly check if this function can be ran.
func _process(_delta: float) -> void:
	_interact() 

# A func checck if both conditions are fulfilled then change the player's scene to
# the end screen.
func _interact():
	if Input.is_action_just_pressed("e_key") and can_interact == true:
		get_tree().change_scene_to_file("res://scenes/menus/end_screen.tscn")

# Signal checking once a body has entered the area2d and is in player, the can interact boolean
# boolean will get set to true.
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		can_interact = true
