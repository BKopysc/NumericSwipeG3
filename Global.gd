extends Node

var level_selected = 0
var session_high_score = 0

const TileVariants = {
	BLANK = "blank",
	DEFAULT = "default",
	ZERO = "0",
	ONE = "1",
	TWO = "2",
	THREE = "3",
	FOUR = "4",
	FIVE = "5",
	SIX = "6",
	SEVEN = "7",
	EIGHT = "8",
	NINE = "9"
	}

func getTileVariants():
	return TileVariants

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_level(level):
	level_selected = level

func get_level():
	return level_selected
