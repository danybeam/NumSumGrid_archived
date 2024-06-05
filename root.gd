extends Control



# Called when the node enters the scene tree for the first time.
func _ready():
	var coordinatesToPlace = Vector2i(Constants.grid_element_size,Constants.grid_element_size)
	var gridCoordinates = Vector2i(0,0)
	for yCoord in Constants.grid_size:
		for xCoord in Constants.grid_size:
			var _button = BlockableButton.new()
			_button.position = coordinatesToPlace
			_button.size = Vector2(Constants.grid_element_size,Constants.grid_element_size)
			_button.element_value = randi_range(1,9)
			_button.text = str(_button.element_value)
			_button.grid_coordinates = gridCoordinates
			add_child(_button)
			coordinatesToPlace += Vector2i(Constants.grid_element_size + Constants.grid_spacing,0)
			gridCoordinates += Vector2i(1,0)
		coordinatesToPlace = Vector2i(Constants.grid_element_size,coordinatesToPlace.y + Constants.grid_element_size + Constants.grid_spacing)
		gridCoordinates = Vector2i(0,gridCoordinates.y+1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
