extends Node3D

@onready var player = $Player

func _ready():
	await get_tree().create_timer(1).timeout
	$RichTextLabel.set_visible(false)
	$RichTextLabel2.set_visible(true)
	await get_tree().create_timer(1).timeout
	$RichTextLabel2.set_visible(false)
	$RichTextLabel3.set_visible(true)
	await get_tree().create_timer(1).timeout
	$RichTextLabel3.set_visible(false)

func _physics_process(delta):
	get_tree().call_group("enemies", "update_target_location", player.position)
