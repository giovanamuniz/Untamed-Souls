extends Control

func _ready():
	
	# Espera 8 segundos para leitura
	await get_tree().create_timer(8.0).timeout
	FadeControl.transition()
	await FadeControl.on_transition_finished
	
	get_tree().change_scene_to_file("res://Level2/scenes/menus/win_screen.tscn")

func _process(delta):

	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://Level2/scenes/menus/win_screen.tscn")
