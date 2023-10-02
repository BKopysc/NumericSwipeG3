extends Node2D


var timer_ctr = 0
var move_ctr = 0
var moved_combos_dict = {2: 0, 3: 0, 4:0 ,5:0,6:0}
var level_selected = Global.LevelVariants.STANDARD_EASY

# Called when the node enters the scene tree for the first time.
func _ready():
	if(Global.level_selected == Global.LevelVariants.LEGACY_FIRST):
		$BasicTimer.wait_time = 1
	$BasicTimer.start()
	level_selected = Global.level_selected

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_LevelHud_game_exited():
	get_tree().change_scene("res://Main.tscn")


func _on_LevelHud_game_paused(state):
	if(state):
		if(level_selected == Global.LevelVariants.LEGACY_FIRST):
			$BasicTimer.stop()
		else:
			$BasicTimer.paused = true
	else:
		if(level_selected == Global.LevelVariants.LEGACY_FIRST):
			$BasicTimer.start()
		else:
			$BasicTimer.paused = false


func _on_BasicTimer_timeout():
	timer_ctr = stepify(timer_ctr + $BasicTimer.wait_time, 0.1)
	$LevelHud.update_timer(timer_ctr)


func _on_TileContainer_moved(is_success, moved_combo = 0):
	move_ctr += 1
	if(moved_combo != 0):
		print(moved_combo)
		moved_combos_dict[moved_combo] += 1
	Global.play_tile_sound(is_success)
	$LevelHud/CanvasLayer/HBoxContainerMove/MoveLabel.text = str(move_ctr)


func _on_TileContainer_game_end():
	var score = _calc_game_results(self.level_selected)
	Global.set_previous_game(timer_ctr, move_ctr, 0, score)
	Global.play_end()
	get_tree().change_scene("res://hud/EndHud.tscn")

func _calc_game_results(level_id, skipped_ctr = 0, is_full_skipped = false):
	var score = 0
	score += skipped_ctr * Global.skip_score_val
	
	if(is_full_skipped): return
	
	if(level_id == Global.LevelVariants.STANDARD_EASY || level_id == Global.LevelVariants.STANDARD_HARD):
		var part_score = 0
		for n in self.moved_combos_dict.keys():
			part_score += moved_combos_dict[n] * Global.ScorePoints.get(n)
		score += part_score + timer_ctr*Global.time_score_multiplier
		
		if(level_id == Global.LevelVariants.STANDARD_HARD):
			score += floor(score*Global.hard_game_multiplier)
			
	elif(level_id == Global.LevelVariants.LEGACY_EASY):
		score += timer_ctr*move_ctr
	elif(level_id == Global.LevelVariants.LEGACY_HARD):
		score += floor(timer_ctr*move_ctr*Global.hard_game_multiplier)
		
	return score

func _on_LevelHud_game_skipped():
	var left = $TileContainer.get_num_of_tiles_left()
	var score = _calc_game_results(self.level_selected, left)
	Global.set_previous_game(timer_ctr, move_ctr, left, score)
	Global.play_end()
	get_tree().change_scene("res://hud/EndHud.tscn")


func _on_TileContainer_no_moves():
	$LevelHud.show_skip_hint()
