tool
extends EditorPlugin

var DrawOnButton = preload("res://addons/draw-on/button.tscn")
var _button

func _enter_tree():
	_button = DrawOnButton.instance()
	add_control_to_container(CONTAINER_TOOLBAR, _button)
	pass


func _exit_tree():
	remove_control_from_container(CONTAINER_TOOLBAR, _button)
	_button.free()
	pass

func make_visible(visible):
	pass

