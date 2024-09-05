extends GridContainer

var buttonScene = preload("res://Scenes/blockable_button.tscn")
var labelScene = preload("res://Scenes/result_root.tscn")

signal level_complete
signal restarted

var _level_size

# Called when the node enters the scene tree for the first time.
func _ready():
	set_grid()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func set_grid(_with_signal:bool = true):
	self.set_columns(Constants.grid_size+1) # +1 to leave the constant in constants file as just the inner grid elements
	self._level_size = Constants.grid_size * Constants.grid_size
	var emptyGrid = Control.new()
	add_child(emptyGrid)
	for header in (self.get_columns()-1):
		var localResult = labelScene.instantiate()
		localResult.set_custom_minimum_size(Vector2(Constants.grid_element_size,Constants.grid_element_size))
		localResult.set_grid_coordinates(Vector2i(header,-1))
		add_child(localResult)

	#var gridCoordinates = Vector2i(0,0)
	for yCoord in Constants.grid_size:
		var localResult = labelScene.instantiate()
		localResult.set_custom_minimum_size(Vector2(Constants.grid_element_size,Constants.grid_element_size))
		localResult.set_grid_coordinates(Vector2i(-1,yCoord))
		add_child(localResult)
		for xCoord in Constants.grid_size:
			var _button = buttonScene.instantiate()
			_button.grid_coordinates = Vector2i(xCoord,yCoord)
			_button.connect("correct_guess",on_correct_guess)
			add_child(_button)
	
	var buttonList = []
	var labelList = []
	for child in get_children():
		if child  is BlockableButton:
			buttonList.append(child)
		elif child is ResultLabel:
			labelList.append(child)
	
	for button in buttonList:
		for label in labelList:
			label.process_button(button)
	
	#if with_signal:
	#reset_size()
	#call_deferred("emit_signal","restarted")
		#emit_signal("restarted")

func reset_grid():
	get_child(0).queue_free()
	self.set_columns(Constants.grid_size+1) # +1 to leave the constant in constants file as just the inner grid elements
	var buttons = get_tree().get_nodes_in_group("GameButton")
	var labels = get_tree().get_nodes_in_group("ResultLabels")
	for label in labels:
		label.visible = false
		remove_child(label)
		label.queue_free()
	
	for button in buttons:
		button.visible = false
		remove_child(button)
		button.queue_free()
	
	#call_deferred("set_grid")
	set_grid()

func on_correct_guess():
	_level_size -= 1
	if _level_size == 0:
		emit_signal("level_complete")
