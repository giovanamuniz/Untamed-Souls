extends Control

@onready var video_player = $VideoStreamPlayer

func _ready():

	video_player.play()

func _on_video_stream_player_finished():
	ir_para_fase_1()

func _process(delta):
	# Permite pular o vídeo apertando Enter, Espaço ou Esc
	if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_cancel"):
		ir_para_fase_1()

func ir_para_fase_1():
	get_tree().change_scene_to_file("res://Level1/main.tscn")
