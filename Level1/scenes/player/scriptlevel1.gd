extends CharacterBody3D

# --- VARIÁVEIS EXPORTADAS (Para você ajustar no Inspector igual na sua fase) ---
@export var speed: float = 10.0
@export var jump_force: float = 15.0
@export var gravity: float = 28.0
@export var camera_vertical_offset: float = 3.0

# --- REFERÊNCIAS AOS NÓS DA B ---
# Aqui eu adaptei para os nomes que existem na cena dela
@onready var model_node: Node3D = $"test (2)" # O modelo 3D dela
@onready var animation_player: AnimationPlayer = $"test (2)/AnimationPlayer"
@onready var raycast: RayCast3D = $RayCast3D
@onready var camera_controller: Node3D = $Camera_Controller
# Se o som tiver outro nome, ajuste aqui (ex: $SomPulo)
@onready var sound_jump = $SomPulo 

var xform: Transform3D
var velocity_x: float = 0.0

# AJUSTE DE ROTAÇÃO
# Se o macaco ficar de costas, mude isso para 90.0, -90.0 ou 180.0
const ROTATION_OFFSET_Y = 0.0 

func _physics_process(delta: float) -> void:
	
	# 1. MOVIMENTO (Apenas Esquerda e Direita)
	var input_dir: float = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var target_velocity_x: float = input_dir * speed

	# 2. ANIMAÇÕES
	if is_on_floor():
		if input_dir != 0.0:
			# Verifica se a animação existe antes de tocar para evitar erros
			if animation_player.has_animation("Corrida"):
				animation_player.play("Corrida")
		else:
			if animation_player.has_animation("Espera"):
				animation_player.play("Espera")

	# 3. GRAVIDADE
	if not is_on_floor():
		velocity.y -= gravity * delta

	# 4. PULO
	if Input.is_action_just_pressed("jump") and is_on_floor():
		if sound_jump: sound_jump.play()
		velocity.y = jump_force
		if animation_player.has_animation("Action"):
			animation_player.play("Action")

	# 5. APLICA A FÍSICA (Com Lerp para suavidade igual sua fase)
	if input_dir != 0.0: 
		velocity.x = lerp(velocity.x, target_velocity_x, speed * delta)
	else: 
		velocity.x = lerp(velocity.x, 0.0, speed * delta)

	# 6. TRAVA O EIXO Z (Transforma em 2.5D)
	velocity.z = 0.0
	global_position.z = 0.0 # Garante que ele nunca saia da linha central

	# 7. ALINHAMENTO COM O CHÃO
	var floor_normal: Vector3 = Vector3.UP
	if is_on_floor() and raycast and raycast.is_colliding():
		floor_normal = raycast.get_collision_normal()
		align_with_floor(floor_normal)
	else:
		align_with_floor(Vector3.UP)

	move_and_slide()

	# 8. ROTAÇÃO DO MODELO (Olhar Esquerda/Direita)
	if model_node:
		if input_dir > 0.1: # Direita
			# Se ele olhar para o fundo, altere o valor abaixo
			model_node.rotation_degrees.y = 0.0 + ROTATION_OFFSET_Y
		elif input_dir < -0.1: # Esquerda
			# Se ele olhar para a câmera, altere o valor abaixo
			model_node.rotation_degrees.y = 180.0 + ROTATION_OFFSET_Y

	# 9. CONTROLE DE CÂMERA (Segue suavemente)
	if camera_controller:
		# A câmera agora segue o X e Y, mas mantém o Z dela fixo
		var cam_target = Vector3(global_position.x, global_position.y + camera_vertical_offset, camera_controller.global_position.z)
		camera_controller.global_position = camera_controller.global_position.lerp(cam_target, 8.0 * delta)


func align_with_floor(floor_normal: Vector3) -> void:
	xform = global_transform
	xform.basis.y = floor_normal
	xform.basis.x = -xform.basis.z.cross(floor_normal)
	xform.basis = xform.basis.orthonormalized()
	global_transform = global_transform.interpolate_with(xform, 0.15)

# Certifique-se de conectar o sinal na aba Node novamente se tiver desconectado
func _on_fallzone_body_entered(body: Node3D) -> void:
	# Verifique se você tem o script Global ou FadeControl neste projeto
	# Se der erro aqui, comente as linhas abaixo
	if has_node("/root/Global"):
		get_node("/root/Global").take_damage()
	else:
		# Fallback simples caso não tenha o global
		get_tree().reload_current_scene()
	
func _on_switch_scenes_body_entered(body: Node3D) -> void:

	if body is CharacterBody3D:
		print("Player entrou na zona de troca de fase!") 
		
		FadeControl.transition()
		await FadeControl.on_transition_finished
		
		if is_inside_tree():
			get_tree().change_scene_to_file("res://Level2/scenes/levels/Level2.tscn")
