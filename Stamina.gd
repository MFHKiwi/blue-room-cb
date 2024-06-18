extends ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	value -= 100


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed('sprint'):
			value -= 0.75
	else:
		if value <= 100:	
			value += 20*delta
