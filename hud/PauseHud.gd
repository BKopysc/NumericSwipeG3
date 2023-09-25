extends CanvasLayer

signal resume_pressed
signal exit_pressed
# Declare member variables here. Examples:
# var a = 2
# var b = "text"



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ResumeButton_pressed():
	emit_signal("resume_pressed")


func _on_ExitButton_pressed():
	emit_signal("exit_pressed")
