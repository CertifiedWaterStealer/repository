extends Control

# Once the game starts finds the mode and call it main.
@onready var main = $"../.."

# Signal pausing the game.
func _on_resume_button_pressed() -> void:
	main._pause_menu()

# Quiting the game.
func _on_quit_button_pressed() -> void:
	get_tree().quit()
