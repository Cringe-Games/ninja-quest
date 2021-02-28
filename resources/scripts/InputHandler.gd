extends Node2D

# This module handles mouse/keyboard inputs
signal mouse_hover
signal mouse_click

func post_init():
	emit_signal("mouse_hover", get_global_mouse_position())

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		emit_signal("mouse_hover", event.position)
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("mouse_click", event.position)
		if event.button_index == BUTTON_LEFT and not event.pressed:
			emit_signal("mouse_hover", event.position)
