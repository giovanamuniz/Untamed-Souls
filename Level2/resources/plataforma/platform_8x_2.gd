extends AnimatableBody3D

@export var position_a := Vector3()
@export var position_b := Vector3()
@export var time : float = 2.0
@export var pause : float = 0.7

func _ready() -> void:
	move()

func move():
	var move_tween = create_tween().set_loops()
	
	move_tween.set_trans(Tween.TRANS_CUBIC)
	move_tween.set_ease(Tween.EASE_IN_OUT)
	
	move_tween.tween_interval(pause) 
	move_tween.tween_property(self, "position", position_b, time)
	
	move_tween.tween_interval(pause)
	move_tween.tween_property(self, "position", position_a, time)
