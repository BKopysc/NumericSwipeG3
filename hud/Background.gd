extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	_set_background()
	
func _set_background():
	$ColorRect.color = Global.active_theme.background
	
func refresh_color():
	_set_background()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
