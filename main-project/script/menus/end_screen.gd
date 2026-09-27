extends Control

# A signal checking if the button has been pressed. If pressed then the it will changed the player's
# scene to the main menu 
func _on_return_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")
