extends Node2D

var timer_ctr = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	$BasicTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_basic_timer_timeout():
	timer_ctr += 1
	$GameHud.update_timer(timer_ctr)



func _on_game_hud_game_paused(state):
	if(state):
		$BasicTimer.stop()
	else:
		$BasicTimer.start()


func _on_game_hud_game_exit():
	get_tree().change_scene_to_file("res://main.tscn")
