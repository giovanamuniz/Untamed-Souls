extends Node3D

# 1. NOVO: Variável para definir onde o player vai renascer.
# O @export permite que você mude isso no Inspetor para cada armadilha diferente!
@export var posicao_inicial = Vector3(-10, 0.308, 0.516)

# Referências para os modelos
@export var modelo_aberto: Node3D # Mudei para @export para facilitar (como fizemos antes)
@export var modelo_fechado: Node3D

# Variável para não disparar a armadilha mais de uma vez
var ativada = false

func _ready():
	# Garante o estado inicial
	if modelo_aberto:
		modelo_aberto.show()
	if modelo_fechado:
		modelo_fechado.hide()

func _on_gatilho_body_entered(body):
	
	# Se já foi ativada, não faz mais nada
	if ativada:
		return

	# Verifique se quem entrou é o player
	if body.is_in_group("player"):
		
		print("Armadilha ativada! Dano e Teleporte.")
		
		# --- PARTE 1: A Lógica da Armadilha (Visual) ---
		ativada = true
		
		if modelo_aberto:
			modelo_aberto.hide()
		
		if modelo_fechado:
			modelo_fechado.show()

		# --- PARTE 2: Dano (Igual ao Cachorro) ---
		Global.take_damage(1)

		# --- PARTE 3: Teleporte (Igual ao Cachorro) ---
		# Zera a velocidade para ele não cair "pesado"
		body.velocity = Vector3.ZERO
		
		# Se você criou a função "morrer_e_voltar" no player (recomendado):
		if body.has_method("morrer_e_voltar"):
			body.morrer_e_voltar(posicao_inicial)
		else:
			# Se não criou, usa o método direto do seu script do cachorro:
			body.global_position = posicao_inicial
