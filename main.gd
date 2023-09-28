extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	_toggle_music(Global.is_music)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _toggle_music(state):
	if(state):
		$CanvasLayer/MarginContainer2/VBoxContainer/HBoxContainer/MusicButton.icon = preload("res://assets/hud/music.png")
	else:
		$CanvasLayer/MarginContainer2/VBoxContainer/HBoxContainer/MusicButton.icon = preload("res://assets/hud/music_mute.png")
	
func _toggle_sound(state):
	if(state):
		$CanvasLayer/MarginContainer2/VBoxContainer/HBoxContainer/SoundButton.icon = preload("res://assets/hud/sound.png")
	else:
		$CanvasLayer/MarginContainer2/VBoxContainer/HBoxContainer/SoundButton.icon = preload("res://assets/hud/sound-mute.png")
	

func _on_PlayButton_pressed():
	get_tree().change_scene("res://levels/LevelSelect.tscn")


func _on_MusicButton_pressed():
	_toggle_music(Global.toggle_music())


func _on_SoundButton_pressed():
	_toggle_sound(Global.toggle_sound())


func _on_HelpButton_pressed():
	get_tree().change_scene("res://hud/HelpHud.tscn")
