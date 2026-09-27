extends Area2D

# Specifying the variables type.
var player: CharacterBody2D

# Can interact intialy will equal to false.
var can_interact: bool = false

# Value will constantly equal 100 and not change.
const value: int = 500

# When the game starts, find the node and call it main.
@onready var main = $"../.."

# When this start, find every node in player the "Player" group and store it into a variable.
func _ready():
	for node in get_tree().get_nodes_in_group("Player"):
		player = node

# Will constantly check if this function can be ran.
func _process(_delta: float) -> void:
	_interact() 

# Once e is pressed and can interact is equal to true gems counter and score counter will go up
# in numbers, with its value being stored in a variable. Then the whole item will disappear.
func _interact():
	if Input.is_action_just_pressed("e_key") and can_interact == true:
		main.gems_counter += 1
		main.money_score += value
		queue_free()

# Signal checking once a body has entered the area2d and is in player, the can interact boolean
# boolean will get set to true.
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		can_interact = true
