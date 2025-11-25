extends Control

func _on_play_button_pressed() -> void:
	SoundManager.stop_menu_music()
	SoundManager.play_button_sound()
	Global.reset_health()
	get_tree().change_scene_to_file("res://Level2/scenes/menus/intro.tscn")


func _on_leave_button_pressed() -> void:
	get_tree().quit()


func _on_controls_button_pressed() -> void:
	$PopupControles.show()


func _on_go_back_button_pressed() -> void:
	$PopupControles.hide()
	
func _input(event):
	if event.is_action_pressed("ui_cancel") and $PopupControles.visible:
		$PopupControles.hide()
	
