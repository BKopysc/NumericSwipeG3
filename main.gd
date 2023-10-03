extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	_set_theme_btn()
	_toggle_music(Global.is_music)
	var username = $SavesServiceNode.check_if_user_is_saved() 
	if(username == ""):
		$UsernameHud.show()
	else:
		$CanvasLayer/UserButton.text = username
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _set_theme_btn():
	if(Global.active_theme == Global.light_theme):
		$CanvasLayer/ThemeButton.icon = preload("res://assets/hud/night32.png")
	else:
		$CanvasLayer/ThemeButton.icon = preload("res://assets/hud/sun32.png")

func _toggle_music(state):
	if(state):
		$CanvasLayer/HBoxContainer/MusicButton.icon = preload("res://assets/hud/music32.png")
	else:
		$CanvasLayer/HBoxContainer/MusicButton.icon = preload("res://assets/hud/music_mute32.png")
	
func _toggle_sound(state):
	if(state):
		$CanvasLayer/HBoxContainer/SoundButton.icon = preload("res://assets/hud/sound32.png")
	else:
		$CanvasLayer/HBoxContainer/SoundButton.icon = preload("res://assets/hud/sound-mute32.png")
	

func _on_PlayButton_pressed():
	get_tree().change_scene("res://levels/LevelSelect.tscn")


func _on_MusicButton_pressed():
	_toggle_music(Global.toggle_music())


func _on_SoundButton_pressed():
	_toggle_sound(Global.toggle_sound())
	$Background.refresh_color()

func _on_HelpButton_pressed():
	get_tree().change_scene("res://hud/HelpHud.tscn")


func _on_ThemeButton_pressed():
	Global.toggle_theme()
	_set_theme_btn()
	$Background.refresh_color()


func _on_UsernameHud_success(user_edit):
	$UsernameHud.hide()
	$CanvasLayer/UserButton.text = user_edit


func _on_UserButton_pressed():
	$UsernameHud.show()
