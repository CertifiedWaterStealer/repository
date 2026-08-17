class_name Enemy
extends CharacterBody2D

var health: int = 30

@export var health_ui: ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_ui.max_value = health
	health_ui.value = health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if health < 1:
		queue_free()
		print("enemy died")
	elif health < 30:
		health_ui.show()
	health_ui.value = health

func _take_damage(damage: int) -> void:
	health -= damage
	print(health)
	print("it worked!!!")
