extends ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	value -= 100


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed('sprint') and Input.is_action_pressed("forward"):
			value -= 1
	elif Input.is_action_pressed('sprint') and Input.is_action_pressed("backward"):
			value -= 1
	elif Input.is_action_pressed('sprint') and Input.is_action_pressed("left"):
			value -= 1
	elif  Input.is_action_pressed('sprint') and Input.is_action_pressed("right"):
			value -= 1
	else:
		if value <= 100:	
			value += 20*delta

