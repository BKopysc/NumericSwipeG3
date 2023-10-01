extends Node2D


var timer_ctr = 0
var move_ctr = 0
var moved_combos_dict = {2: 0, 3: 0, 4:0 ,5:0,6:0}
var level_selected = Global.LevelVariants.STANDARD_EASY

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
		$BasicTimer.paused = true
	else:
		$BasicTimer.paused = false


func _on_BasicTimer_timeout():
	timer_ctr = stepify(timer_ctr + $BasicTimer.wait_time, 0.1)
	$LevelHud.update_timer(timer_ctr)


func _on_TileContainer_moved(is_success, moved_combo = 0):
	move_ctr += 1
	print(moved_combo)
	moved_combos_dict[moved_combo] += 1
	Global.play_tile_sound(is_success)
	$LevelHud/CanvasLayer/HBoxContainerMove/MoveLabel.text = str(move_ctr)


func _on_TileContainer_game_end():
	var score = timer_ctr*move_ctr*10
	Global.set_previous_game(timer_ctr, move_ctr, 0, score)
	Global.play_end()
	get_tree().change_scene("res://hud/EndHud.tscn")

func _calc_game_results(level_id, is_skipped):
	var score = 0
	
	if(level_id == Global.LevelVariants.LEGACY_EASY || level_id == Global.LevelVariants.STANDARD_EASY ):
		score += timer_ctr*10*move_ctr
		print("easy")
	else:
		score += floor(timer_ctr*10*move_ctr*0.7)
			

func _on_LevelHud_game_skipped():
	var left = $TileContainer.get_num_of_tiles_left()
	var skip_ctr = left*150
	var score = timer_ctr*move_ctr*10 + skip_ctr
	Global.set_previous_game(timer_ctr, move_ctr, skip_ctr, score)
	Global.play_end()
	get_tree().change_scene("res://hud/EndHud.tscn")


func _on_TileContainer_no_moves():
	$LevelHud.show_skip_hint()
