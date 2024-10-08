extends Control

var main_scene

func _on_button_pressed() -> void:
	main_scene = preload("res://mvp_map.tscn").instantiate()
	main_scene.get_node("Player").mouse_sensitivity = $VBoxContainer/HSlider.value / 100000
	get_tree().root.add_child(main_scene)
	self.set_visible(false)
	$DeathText.set_visible(false)
	$WinText.set_visible(false)

func _on_player_death() -> void:
	get_tree().root.remove_child(main_scene)
	main_scene.free()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	self.set_visible(true)
	$DeathText.set_visible(true)

func _on_button_2_pressed() -> void:
	get_tree().quit()

func _on_player_win() -> void:
	_on_player_death()
	$DeathText.set_visible(false)
	$WinText.set_visible(true)
