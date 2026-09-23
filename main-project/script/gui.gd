extends CanvasLayer

const HEALTH_SLOT_SIZE = 4

@export var animated_sprite: AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite.play("health_bar_4")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
