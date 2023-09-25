extends CanvasLayer

signal resume_pressed
signal exit_pressed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func hide_layer():
	$CanvasLayer.hide()

func show_layer():
	$CanvasLayer.show()


func _on_resume_button_pressed():
	resume_pressed.emit()
	

func _on_exit_button_pressed():
	exit_pressed.emit()
