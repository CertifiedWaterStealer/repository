extends CharacterBody2D

var health: int = 3

var overlapping: bool = true

var player: CharacterBody2D

@export var animated_sprite: AnimatedSprite2D

func _ready():
	for node in get_tree().get_nodes_in_group("Player"):
		player = node

func _process(_delta: float) -> void:
	if health <= 0:
		queue_free()

func _on_hit_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("Sword"):
		health -= 1 
		print("sword worked")

func _on_hit_box_body_entered(body: Node2D) -> void:
	if body == player:
		player._take_damage()
		overlapping = true
		print("worked")
