extends Control


func _on_play_button_button_up() -> void:
	pass # Replace with function body.


func _on_settings_button_button_up() -> void:
	pass # Replace with function body.


func _on_credits_button_button_up() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menus/credits.tscn")
	pass # Replace with function body.


func _on_quit_button_button_up() -> void:
	get_tree().quit()
	pass # Replace with function body.
