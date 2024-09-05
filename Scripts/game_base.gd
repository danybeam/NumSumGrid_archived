extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	var new_size = Vector2(0,0)
	var waiting = get_children()
	while not waiting.is_empty():
		var node = waiting.pop_back() as Node
		if node is AcceptDialog:
			continue
		waiting.append_array(node.get_children())
		#print(node.get_class(),node.position,node.global_position,node.size)
		new_size.x = max(new_size.x, (node.global_position.x + node.size.x))
		new_size.y = max(new_size.y, (node.global_position.y + node.size.y))
	#print(new_size)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func onMistake():
	$LifeCounter.mistake()

func on_game_over():
	$AcceptDialog.popup_centered()

func on_game_over_closed():
	restart_game()

func on_grid_ready():
	# For some reason the grid oversizes before shrinking down. This causes the window to be slightly too big in y axis.
	# connecting to item_rect_changed() makes it so that the error corrects itself but it causes the window to be jittery.
	# TODO figure out how to reset the grid either fast enough or sending the signal in the right moment to get an accurate size
	self.global_position = Vector2(Constants.game_viewport_margin,Constants.game_viewport_margin)
	var new_size = $GameGrid.size + $GameGrid.global_position
	new_size.x = max(new_size.x,$TextureButton.global_position.x+$TextureButton.size.x)
	new_size.x += Constants.game_viewport_margin
	new_size.y += Constants.game_viewport_margin
	connect_all_buttons()
	$/root.set_min_size(new_size)
	$/root.set_size(new_size)
	

func on_level_complete():
	Constants.increase_level()
	restart_game()

func restart_game():
	$LifeCounter.reset()
	$GameGrid.reset_grid()

func connect_all_buttons():
	
	var buttons = get_tree().get_nodes_in_group("GameButton")
	for button in buttons:
		if not button.is_connected("incorrect_guess",onMistake):
			button.connect("incorrect_guess",onMistake)
