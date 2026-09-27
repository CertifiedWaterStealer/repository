extends Node2D

# The gems will first equal to 0
var gems_counter: int = 0

# money equals to 0
var money_score: int = 0

# making the bool equal false first
var paused: bool = false

# Once the game starts, get the pause menu and make it variable.
@onready var pause_menu = $GUI/PauseMenu

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$GUI/GemCounter.text = str(gems_counter)
	$GUI/MoneyScore.text = str(money_score)
	if Input.is_action_just_pressed("esc"):
		_pause_menu()

# changes the game time to pause and unpause it. 
func _pause_menu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	paused = !paused
