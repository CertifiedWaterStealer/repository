extends CharacterBody2D

var health: int = 50
var player: CharacterBody2D

@export var health_bar: ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_bar.max_value = health
	health_bar.value = health
	for node in get_tree().get_nodes_in_group("player"):
		player = node

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func take_damage(damage: int) -> bool:
	var dead: bool = false
	if health > 1:
		health -= damage
		if not health_bar.visible:
			health_bar.show()
	else:
		dead = true 
	return dead
