extends Node3D

var count_down = 0.25

func _ready():
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 0.5
	timer.autostart = true

func toggle():
	if $SpotLight3D.visible == true:
		$SpotLight3D.visible = false
	else:
		if $ProgressBar2.value > 0:
			$SpotLight3D.visible = true
		else:
			pass

func _process(delta):
	count_down -= delta
	if count_down <= 0 and $ProgressBar2.value > 0 and $SpotLight3D.visible == true:
		$ProgressBar2.value -= 1
		count_down = 0.25
	if $ProgressBar2.value <= 0:
		$SpotLight3D.visible = false
