extends CharacterBody2D

# Stores the integer of 15
var health: int = 15

# making the variable instantly true
var overlapping: bool = true

# Specifying the variables type.
var player: CharacterBody2D

# connecting a node in a stored variable
@export var sprite: Sprite2D

# connecting a node in a stored variable
@export var health_ui: ProgressBar

# When this start, find every node in player the "Player" group and store it into a variable.
func _ready():
	health_ui.value = health
	health_ui.max_value = health
	for node in get_tree().get_nodes_in_group("Player"):
		player = node

# Will constantly check if this function can be ran.
func _process(_delta: float) -> void:
	if health <= 0:
		queue_free()

# Signal checking once the player's sworrd's area 2d has entered the enemies area 2d and
# then it will deal damage to the enemy, lower it's health. And also showing its health bar
# to indicate to the player it's hp. 
func _on_hit_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("Sword"):
		health -= 1 
		health_ui.value = health
		if not health_ui.visible:
			health_ui.show()

# if a body has entered, the signal will make the player take damage by calling the player's
# script's take damage function. 
func _on_hit_box_body_entered(body: Node2D) -> void:
	if body == player:
		player._take_damage()
		overlapping = true
