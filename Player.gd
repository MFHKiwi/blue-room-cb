extends CharacterBody3D

# Mouse Sensitivity
@export var mouse_sensitivity = 0.001
# How fast the player moves in meters per second.
@export var speed = 14
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = -750
# A boolean to track if the player is currently jumping
var target_velocity = Vector3.ZERO
@onready var headbob = $Camera3D/AnimationPlayer.speed_scale

@onready var enemy = get_node("/root/MVP_Map/Enemy")

var angle = 0

var basketball_counter = 0

func camera_fov(fov):
		fov = get_viewport().get_camera_3d().fov

func _ready():
	var fov = 75
	# Lock the mouse cursor to the screen
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _unhandled_input(event):
	
	if event is InputEventMouseMotion:
		# Debugging: Print mouse motion for troubleshooting
		#print("Mouse Motion:", event.relative)
		
		# Adjust the rotation of the player based on mouse motion for yaw only
		rotate_y(-event.relative.x * mouse_sensitivity)
	if event is InputEventMouseButton:
		if event.is_action_pressed("button1"):
			print("toggling light")
			get_tree().call_group("flashlight", "toggle")
		elif event.is_action_pressed("button2"):
			print("flashing light")
			get_tree().call_group("flashlight", "flash")

func _physics_process(delta):
	var direction = Vector3.ZERO
	var fov = 75
	#if Input.is_action_pressed("restart"):
	#	get_tree().reload_current_scene()
	
	# Doubles the Speed When pressing the "sprint" keybind
	if Input.is_action_pressed("sprint") and Stamina.value > 0:
		speed = 18
		fov = camera_fov(82)
		$Camera3D/AnimationPlayer.speed_scale = 2
	else:
		fov = camera_fov(75)
		speed = 14
	# Moving the Character Based on the Input Pressed 
	var cam_basis = $Camera3D.global_transform.basis
	if Input.is_action_pressed("backward") or Input.is_action_pressed("forward") or Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		headbob = 1
		$Camera3D/AnimationPlayer.play("walk")
	if Input.is_action_pressed("right"):
		direction += cam_basis.x
	if Input.is_action_pressed("left"):
		direction -= cam_basis.x
	if Input.is_action_pressed("backward"):
		direction += cam_basis.z
	if Input.is_action_pressed("forward"):
		direction -= cam_basis.z
	else:
		pass

	# Ground Velocity
	target_velocity = direction.normalized() * speed

	# Apply falling acceleration when not on the ground
	if not is_on_floor():
		target_velocity.y += fall_acceleration * delta

	# Moving the Character
	velocity = target_velocity
	move_and_slide()
	angle = self.rotation_degrees.y - enemy.rotation_degrees.y
	if angle < 30 and angle > -30:
		enemy.facing = true
	else:
		enemy.facing = false
	for index in range(get_slide_collision_count()):
		var collision = get_slide_collision(index)
		if collision.get_collider().is_in_group("basketball"): 
			basketball_counter += 1
			enemy.set_physics_process(true)
			collision.get_collider().queue_free()
		if collision.get_collider().is_in_group("battery"):
			$Camera3D.get_node("Flashlight").get_node("ProgressBar2").value = 100
		if collision.get_collider().is_class("CharacterBody3D"):
			get_tree().call_group("menu", "_on_player_death")
		break
	if basketball_counter == 5:
		get_tree().call_group("menu", "_on_player_win")
