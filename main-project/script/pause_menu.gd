extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("esc"):
		get_tree().paused = not get_tree().paused
		$pause_menu.visible = not $pause_menu.visible

func _resume() -> void:
	get_tree().paused = not get_tree().paused
	$pause_menu.visible = not $pause_menu.visible

func _quit() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
