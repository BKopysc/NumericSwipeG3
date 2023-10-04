extends VBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func load_user_score(position, username, score):
	$HBoxContainer/PlayerName.text = username
	$HBoxContainer/PlayerPos.text = str(position) + "."
	$HBoxContainer/PlayerScore.text = str(score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
