extends Node3D

func _ready():
	$SpotLight3D2.visible = false

func toggle():
	if $SpotLight3D.visible == true:
		$SpotLight3D.visible = false
	else:
		$SpotLight3D.visible = true

func flash():
	if $ProgressBar2.value > 0:
		$ProgressBar2.value -= 25
		$SpotLight3D2.visible = true
		await get_tree().create_timer(0.25).timeout
		$SpotLight3D2.visible = false
		get_tree().call_group("enemies", "flash")
	else:
		pass
