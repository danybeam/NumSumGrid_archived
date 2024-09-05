extends Control
class_name LifeCounter

@onready var _hp : int = 3
@onready var _active : bool = true

signal game_over

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func mistake():
	if not _active:
		return
	var childName = "HudHeartFull%d" % self._hp
	var childNode = find_child(childName)
	childNode.visible = false
	self._hp -= 1
	if self._hp == 0:
		emit_signal("game_over")
		_active = false

func reset():
	self._hp=3
	self._active = true
	for child in get_children():
		child.visible = true
