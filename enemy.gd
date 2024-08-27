extends CharacterBody3D

@onready var nav_agent = $NavigationAgent3D

var SPEED = 7.50

func _physics_process(delta):
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * SPEED
	velocity = new_velocity
	move_and_slide()
	rotation.y = atan2(velocity.x, velocity.z)
	$Armature/AnimationPlayer.play("Armature|mixamo_com|Layer0")
	
func update_target_location(target_location):
	nav_agent.set_target_position(target_location)
