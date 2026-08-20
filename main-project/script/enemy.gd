class_name Enemy
extends CharacterBody2D

var health: int = 30

const SPEED: float = 250.0

var player: CharacterBody2D

var overlapping: bool = true

@export var health_ui: ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_ui.max_value = health
	health_ui.value = health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if not player == null:
		look_at(player.global_position)
		velocity = SPEED * Vector2(1, 0).rotated(rotation)
		
		health_ui.rotation = -rotation
		
		move_and_slide()

func _take_damage(damage: int) -> bool:
	var dead: bool = false
	if health > 1: 
		health -= damage
		health_ui.value = health
		if not health_ui.visible:
			health_ui.show()
	else:
		dead = true
		queue_free()
	return dead

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == player:
		overlapping = false
