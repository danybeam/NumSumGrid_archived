extends Button

class_name BlockableButton

var grid_coordinates: Vector2i
var element_value: int

signal selected_candidate
signal erased_candidate

func _ready():
	print("ready")
	print(grid_coordinates)
	print(element_value)
	connect("gui_input",self._on_pressed)

func _on_pressed(_event):
	if Input.is_action_pressed("LeftClick"):
		print(grid_coordinates)
		print("left")
		emit_signal("selected_candidate",grid_coordinates)
	if Input.is_action_pressed("RightClick"):
		print(grid_coordinates)
		print("right")
		emit_signal("erased_candidate",grid_coordinates)
