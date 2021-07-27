extends Node2D

onready var nav_2d = $Navigation
onready var line_2d = $Line
onready var character = $Char

func _unhandled_input(event):
	if not event is InputEventMouseButton:
		return

	if event.button_index != BUTTON_LEFT or not event.pressed:
		return

	var new_path = nav_2d.get_simple_path(character.global_position, event.global_position, false)
	line_2d.points = new_path
	character.path = new_path
	
	print(character.global_position);
	print(event.global_position);
