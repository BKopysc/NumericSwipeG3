extends Node2D


var timer_ctr = 0
var move_ctr = 0
var level_selected = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$BasicTimer.start()
	level_selected = Global.level_selected

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_LevelHud_game_exited():
	get_tree().change_scene("res://Main.tscn")


func _on_LevelHud_game_paused(state):
	if(state):
		$BasicTimer.stop()
	else:
		$BasicTimer.start()


func _on_BasicTimer_timeout():
	timer_ctr += 1
	$LevelHud.update_timer(timer_ctr)


func _on_TileContainer_moved(is_success):
	move_ctr += 1
	$LevelHud/CanvasLayer/HBoxContainerMove/MoveLabel.text = str(move_ctr)
	


func _on_TileContainer_game_end():
	var score = timer_ctr*move_ctr
	Global.set_previous_game(timer_ctr, move_ctr, score)
	get_tree().change_scene("res://hud/EndHud.tscn")
