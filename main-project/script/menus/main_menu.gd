extends Control

# Once pressed changed the scene to level 1.
func _play() -> void:
	get_tree().change_scene_to_file("res://scenes/other/level_1.tscn")

# Once pressed quit the entire game and shut it down. 
func _quit() -> void:
	get_tree().quit()
