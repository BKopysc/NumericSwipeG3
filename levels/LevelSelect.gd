extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _change_scene(level_opt):
	Global.set_level(level_opt)
	get_tree().change_scene("res://levels/DefaultLevel.tscn")

func _on_EasyButton_pressed():
	_change_scene(0)


func _on_HardButton_pressed():
	_change_scene(1)
