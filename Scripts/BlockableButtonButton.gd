extends Button

class_name BlockableButton

var grid_coordinates: Vector2i
var element_value: int
var is_solution: bool
var _old_modulate: Color

signal correct_guess
signal incorrect_guess

func _ready():
	self._old_modulate = self.modulate
	_ready_game_element()
	connect("gui_input",self._on_pressed)

func _on_pressed(_event):
	if self.disabled:
		return
	var leftPressed = Input.is_action_just_pressed("LeftClick")
	var rightPressed = Input.is_action_pressed("RightClick")
	
	if leftPressed and self.is_solution or rightPressed and not self.is_solution:
		modulate = Color.GREEN if self.is_solution else Color.GRAY
		self.disabled = true
		emit_signal("correct_guess")
	elif leftPressed and not self.is_solution or rightPressed and self.is_solution:
		modulate = Color.RED
		emit_signal("incorrect_guess")

func _ready_game_element():
	self.element_value = randi_range(1,9)
	self.text = str(self.element_value)
	self.is_solution = randi_range(1,Constants.solution_denominator) > (Constants.solution_denominator - Constants.solution_numerator)

func reset():
	self.modulate = _old_modulate
	self.disabled = false
	_ready_game_element()
