extends CharacterBody3D

# Mouse Sensitivity
@export var mouse_sensitivity = 0.0035
# How fast the player moves in meters per second.
@export var speed = 14
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = -750
# A boolean to track if the player is currently jumping
var target_velocity = Vector3.ZERO

func _ready():
	# Lock the mouse cursor to the screen
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _unhandled_input(event):
	
	if event is InputEventMouseMotion:
		# Debugging: Print mouse motion for troubleshooting
		print("Mouse Motion:", event.relative)
		
		# Adjust the rotation of the player based on mouse motion for yaw only
		rotate_y(-event.relative.x * mouse_sensitivity)
		
		# Rotate the camera along with the player for yaw only
		$Camera3D.rotate_y(-event.relative.x * mouse_sensitivity)

func _physics_process(delta):
	var direction = Vector3.ZERO
	
	if Input.is_action_pressed("restart"):
		get_tree().reload_current_scene()
	
	# Doubles the Speed When pressing the "sprint" keybind
	if Input.is_action_pressed("sprint"):
		speed = 28
	else:
		speed = 14
	# Moving the Character Based on the Input Pressed 
	var cam_basis = $Camera3D.global_transform.basis
	if Input.is_action_pressed("right"):
		direction += cam_basis.x
	elif Input.is_action_pressed("left"):
		direction -= cam_basis.x
	elif Input.is_action_pressed("backward"):
		direction += cam_basis.z
	elif Input.is_action_pressed("forward"):
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


