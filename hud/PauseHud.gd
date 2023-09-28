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

func _toggle_music(state):
	if(state):
		$ColorRect2/MarginContainer/VBoxContainer/HBoxContainer/MusicButton.icon = preload("res://assets/hud/music32.png")
	else:
		$ColorRect2/MarginContainer/VBoxContainer/HBoxContainer/MusicButton.icon = preload("res://assets/hud/music_mute32.png")


func _toggle_sound(state):
	if(state):
		$ColorRect2/MarginContainer/VBoxContainer/HBoxContainer/SoundButton.icon = preload("res://assets/hud/sound32.png")
	else:
		$ColorRect2/MarginContainer/VBoxContainer/HBoxContainer/SoundButton.icon = preload("res://assets/hud/sound-mute32.png")

func _on_ResumeButton_pressed():
	emit_signal("resume_pressed")


func _on_ExitButton_pressed():
	emit_signal("exit_pressed")


func _on_MusicButton_pressed():
	_toggle_music(Global.toggle_music())

func _on_SoundButton_pressed():
	_toggle_sound(Global.toggle_sound())
