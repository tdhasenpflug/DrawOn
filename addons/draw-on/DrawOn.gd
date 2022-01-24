tool
extends Control

onready var Layer = $Drawing
var doDraw = false
var drawing:Line2D

var colorIndex = 0
export var colors = [Color.white, Color.red, Color.blue, Color.green, Color.black]
var shiftHeld = false
var thickness = 8
export var maxThickness = 16.0
export var minThickness = 1.0

func _input(event):
	if event is InputEventWithModifiers:
		shiftHeld = event.shift
		
	if event is InputEventKey && event.scancode == KEY_ESCAPE:
		queue_free()
		
	if event is InputEventMouseButton && event.is_pressed():
		if shiftHeld:
			if event.button_index == BUTTON_WHEEL_UP:
				thickness = clamp(thickness + 1, minThickness, maxThickness)
			elif event.button_index == BUTTON_WHEEL_DOWN:
				thickness = clamp(thickness - 1, minThickness, maxThickness)
		else:
			if event.button_index == BUTTON_WHEEL_UP:
				colorIndex = (colorIndex + 1) % 5
			elif event.button_index == BUTTON_WHEEL_DOWN:
				colorIndex = (colorIndex + 4) % 5
			elif event.button_index == BUTTON_RIGHT:
				for child in Layer.get_children():
					child.queue_free()
	
	if event is InputEventMouseButton && event.button_index == BUTTON_LEFT:
		doDraw = event.pressed
		
		if doDraw:
			drawing = Line2D.new()
			drawing.default_color = colors[colorIndex]
			drawing.end_cap_mode = Line2D.LINE_CAP_ROUND
			drawing.begin_cap_mode = Line2D.LINE_CAP_ROUND
			drawing.joint_mode = Line2D.LINE_JOINT_ROUND
			drawing.width = thickness
			Layer.add_child(drawing)
			pass
	pass
	
	if event is InputEventMouseMotion && doDraw:
		drawing.add_point(event.position)
		pass
	
	pass
	
func _process(delta):
	update()
	
func _draw():
	draw_circle(get_viewport().get_mouse_position(), thickness / 2, colors[colorIndex])
	pass
