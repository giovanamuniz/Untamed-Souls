extends Control

func _on_menu_button_pressed() -> void:
	SoundManager.play_button_sound()
	SoundManager.stop_menu_music()
	get_tree().change_scene_to_file("res://Level2/scenes/menus/menu_title.tscn")


func _on_leave_button_pressed() -> void:
	get_tree().quit()
