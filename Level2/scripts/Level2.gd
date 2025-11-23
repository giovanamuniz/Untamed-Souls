extends Node3D

var scene_path: String = "res://Level2/scenes/levels/Level2.tscn"
var first_scene_path: String = "res://Level2/scenes/levels/Level2.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SoundManager.play_level_music()
	
