extends Node

var game_viewport_margin = 10
var game_save_path = "user://currentLevel.dat"
var game_level: int = 1
var game_initial_lives = 3

var grid_size = 3 # Grid is square so only needs one number
var grid_spacing:int = 10 # pixels
var grid_element_size = 50 # pixels

var solution_numerator = 3
var solution_denominator = 5

func save_game():
	var saveFile = FileAccess.open(Constants.game_save_path,FileAccess.WRITE)
	saveFile.store_64(game_level)
	saveFile.close()

func load_game():
	if not FileAccess.file_exists(game_save_path):
		game_level = 1
		return
	var saveFile = FileAccess.open(Constants.game_save_path,FileAccess.READ)
	game_level = saveFile.get_64()
	calculate_dificulty()

func increase_level():
	game_level += 1
	save_game()
	calculate_dificulty()

# TODO implement real implementation
func calculate_dificulty():
	grid_size = 5
