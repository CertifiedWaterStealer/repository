extends CharacterBody2D

var health: int = 3
var damage = 1

@export var animated_sprite: AnimatedSprite2D

func _process(_delta: float) -> void:
	if health <= 0:
		queue_free()

func _on_hit_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("Sword"):
		health -= 1 

func _on_hit_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Global.health -= damage
		print("worked")
