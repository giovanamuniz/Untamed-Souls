extends CharacterBody3D

const SPEED = 6.0
const JUMP_VELOCITY = 16
const GRAVITY = 28

var xform : Transform3D

# Referências para os nós
@onready var model_node = $"test (2)"
@onready var anim_player = $"test (2)/AnimationPlayer"
@onready var raycast_floor = $RayCast3D

# NOVO: Constante para a rotação do Blender
const BLENDER_ROTATION_OFFSET = deg_to_rad(-90.0)

func _physics_process(delta):
	# Checagem de chão
	var on_floor = raycast_floor.is_colliding()

	# 1. APLICA GRAVIDADE
	if not on_floor:
		velocity.y -= GRAVITY * delta

	# 2. PULO
	if Input.is_action_just_pressed("jump") and on_floor:
		velocity.y = JUMP_VELOCITY
		$SomPulo.play()

	# 3. MOVIMENTO 3D (X e Z)
	var input_dir_x = Input.get_axis("move_left", "move_right")
	var input_dir_z = Input.get_axis("move_forward", "move_backward")
	
	# Cria um vetor de direção 3D
	var direction = Vector3(input_dir_x, 0, input_dir_z).normalized()
	
	if direction != Vector3.ZERO:
		# Aplica velocidade nos eixos X e Z
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		
		# NOVO: Rotação 3D
		# Calcula o ângulo para onde o macaco deve olhar
		var target_angle = atan2(direction.x, direction.z)
		
		# Aplica a rotação, incluindo o offset do Blender
		model_node.rotation.y = target_angle + BLENDER_ROTATION_OFFSET
			
	else:
		# Desacelera nos eixos X e Z
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	# 4. ATUALIZA ANIMAÇÕES
	if not on_floor:
		if anim_player.current_animation != "Action":
			anim_player.play("Action")
	else:
		if direction != Vector3.ZERO: # Se está se movendo (em qualquer direção)
			if anim_player.current_animation != "Corrida":
				anim_player.play("Corrida")
		else: # Se está parado
			if anim_player.current_animation != "Espera":
				anim_player.play("Espera")

	# 5. ALINHAMENTO COM O CHÃO
	if on_floor:
		align_with_floor(raycast_floor.get_collision_normal())
		global_transform = global_transform.interpolate_with(xform, 0.3)
	else:
		align_with_floor(Vector3.UP)
		global_transform = global_transform.interpolate_with(xform, 0.3)
		
	# 6. APLICA MOVIMENTO
	move_and_slide()
	
	# 7. CÂMERA (COM EIXO Z)
	var camera_position = $Camera_Controller.position
	camera_position.x = lerp(camera_position.x, position.x, 0.05)
	camera_position.y = lerp(camera_position.y, position.y, 0.05)
	$Camera_Controller.position = camera_position
	
# Suas funções originais
func align_with_floor(floor_normal):
	xform = global_transform
	xform.basis.y = floor_normal
	xform.basis.x = -xform.basis.z.cross(floor_normal)
	xform.basis = xform.basis.orthonormalized()
	
func _on_fall_zone_body_entered(_body: Node3D) -> void:
	get_tree().call_deferred("change_scene_to_file", "res://main.tscn")
	
