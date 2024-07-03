extends Node3D

func toggle():
	if $SpotLight3D.visible == true:
		$SpotLight3D.visible = false
	else:
		$SpotLight3D.visible = true
