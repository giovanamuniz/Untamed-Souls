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
		Global.add_health(1)

		# --- PARTE DO SOM ---
		
		# Toca o som (se o nó existir)
		if has_node("SomColeta"):
			$SomColeta.play()
		
		# Desativa a colisão IMEDIATAMENTE para o player não pegar a mesma banana duas vezes
		$CollisionShape3D.set_deferred("disabled", true)
		
		# Esconde a banana visualmente (ela fica invisível, parecendo que sumiu)
		hide()
		
		# Espera o som terminar de tocar
		if has_node("SomColeta"):
			await $SomColeta.finished

		# 3. SÓ AGORA destrói a banana de verdade
		queue_free()
