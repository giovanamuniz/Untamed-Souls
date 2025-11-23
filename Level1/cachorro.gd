extends Area3D

# COLOQUE AQUI AS COORDENADAS DO INÍCIO DA SUA FASE
# (Veja como descobrir esses números abaixo)
var posicao_inicial = Vector3(-10, 0.308, 0.516) 

func _on_body_entered(body):
	# Verifica se é o Player
	if body.is_in_group("player"):
		
		# 1. Tira um coração (usando seu Global que já funciona)
		Global.take_damage(1)
		
		# 2. Zera a velocidade para ele não continuar escorregando
		body.velocity = Vector3.ZERO
		
		# 3. Teleporta o jogador para o início
		body.global_position = posicao_inicial
		
		print("O cachorro pegou! Voltando ao início...")
		
		
