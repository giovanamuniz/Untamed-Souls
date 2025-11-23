extends Area3D

@export var forca_pulo = 35.0

func _on_body_entered(body):
	
	if body.is_in_group("player"):
		
	
		body.velocity.y = forca_pulo
