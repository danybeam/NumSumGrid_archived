extends ConfirmationDialog

var game = preload("res://Scenes/game_base.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$/root.size = self.size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass



func _on_confirmed():
	transition_to_game()


func _on_canceled():
	Constants.load_game()
	transition_to_game()

func transition_to_game():
	$/root.add_child(game.instantiate())
