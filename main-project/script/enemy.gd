class_name Enemy
extends CharacterBody2D

var health: int = 50

@export var health_bar: ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_bar.max_value = health
	health_bar.value = health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if health < 1:
		print("The enemy died")
	elif health < 50:
		health_bar.show()

func _take_damage(damage: int) -> void:
	health -= damage
	print("it worked!!!")
