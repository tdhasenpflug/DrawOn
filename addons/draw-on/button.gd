tool
extends Button

var DrawLayer = preload("res://addons/draw-on/drawing.tscn")
var _drawing

func _on_Button_pressed():
	_drawing = DrawLayer.instance()
	get_tree().get_root().add_child(_drawing)
	pass
