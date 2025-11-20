extends Area3D

# Velocidade da rotação da banana
const ROT_SPEED = 2

# Chamado a cada frame
func _process(delta: float) -> void:
	# Faz a banana girar sobre si mesma
	rotate_y(deg_to_rad(ROT_SPEED))

# Chamado quando um corpo entra na área de colisão
func _on_body_entered(body: Node3D):
	
	# 1. Verifica se o corpo que entrou está no grupo "player"
	if body.is_in_group("player"):
		
		# 2. Chama a função "add_health" no script Global
		# (Esta é a linha que estava faltando no seu script)
		Global.add_health(1)

		# 3. Faz a banana desaparecer permanentemente
		queue_free()
