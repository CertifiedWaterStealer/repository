extends Node2D

var gems_counter = 0
var money_score = 0

@onready var pause_menu = $GUI/PauseMenu

var paused = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$GUI/GemCounter.text = str(gems_counter)
	$GUI/MoneyScore.text = str(money_score)
	if Input.is_action_just_pressed("esc"):
		_pause_menu()

func _pause_menu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	paused = !paused
