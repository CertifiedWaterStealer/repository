extends Node2D

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("esc"):
		get_tree().paused = not get_tree().paused
		$CanvasLayer.visible = not $CanvasLayer.visible

func _resume() -> void:
	get_tree().paused = not get_tree().paused
	$CanvasLayer.visible = not $CanvasLayer.visible

func _quit() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
