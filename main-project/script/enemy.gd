extends CharacterBody2D

var health: int = 50
var player: CharacterBody2D

@export var health_bar: ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for node in get_tree().get_nodes_in_group("player"):
		player = node

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
