extends Node2D

# This module handles mouse/keyboard inputs
signal mouse_hover
signal mouse_click

# Internal state
var pressed: bool = false

func post_init():
	emit_signal("mouse_hover", get_global_mouse_position())

func _unhandled_input(event):
	if event is InputEventMouseMotion and not pressed:
		emit_signal("mouse_hover", event.position)
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			pressed = true
			emit_signal("mouse_click", event.position)
		if event.button_index == BUTTON_LEFT and not event.pressed:
			pressed = false
			emit_signal("mouse_hover", event.position)
