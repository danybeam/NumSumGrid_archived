extends Panel

class_name ResultLabel

var _value : int = 0
var _gridCoordinates : Vector2i
var _labelRef: Label

func set_value(value:int):
	_value = value

func set_grid_coordinates(value:Vector2i):
	_gridCoordinates = value

# Called when the node enters the scene tree for the first time.
func _ready():
	var centerContainerChild = CenterContainer.new()
	centerContainerChild.set_custom_minimum_size(self.get_size())
	add_child(centerContainerChild)
	
	var styleBox = StyleBoxFlat.new()
	styleBox.bg_color = Color.DARK_GRAY
	self.add_theme_stylebox_override("panel",styleBox)

	var label = Label.new()
	_labelRef = label
	label.text = str(_value)
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

	#centerContainerChild.set_size(self.get_size())
	centerContainerChild.add_child(label)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func process_button(button: BlockableButton):
	if not button.is_solution:
		return
	if _gridCoordinates.x == -1 and not _gridCoordinates.y == button.grid_coordinates.y:
		return
	if _gridCoordinates.y == -1 and not _gridCoordinates.x == button.grid_coordinates.x:
		return
	
	self._value += button.element_value
	_labelRef.text = str(self._value)
