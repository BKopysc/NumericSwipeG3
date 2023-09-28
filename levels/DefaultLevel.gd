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
	Global.play_tile_sound(is_success)
	$LevelHud/CanvasLayer/HBoxContainerMove/MoveLabel.text = str(move_ctr)
	


func _on_TileContainer_game_end():
	var score = timer_ctr*move_ctr
	Global.set_previous_game(timer_ctr, move_ctr, 0, score)
	Global.play_end()
	get_tree().change_scene("res://hud/EndHud.tscn")


func _on_LevelHud_game_skipped():
	var left = $TileContainer.get_num_of_tiles_left()
	var skip_ctr = left*150
	var score = timer_ctr*move_ctr + skip_ctr
	Global.set_previous_game(timer_ctr, move_ctr, skip_ctr, score)
	Global.play_end()
	get_tree().change_scene("res://hud/EndHud.tscn")


func _on_TileContainer_no_moves():
	$LevelHud.show_skip_hint()
