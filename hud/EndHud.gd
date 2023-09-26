extends Control



# Called when the node enters the scene tree for the first time.
func _ready():
	if(Global.is_high_score):
		$CanvasLayer/NewBestScoreLabel.show()
		Global.disable_high_score_flag()
	
	$CanvasLayer/VBoxContainer/TimeLabel.text += str(Global.previous_timer_ctr)
	$CanvasLayer/VBoxContainer/MovesLabel.text += str(Global.previous_move_ctr)
	$CanvasLayer/VBoxContainer/HBoxContainer/AllScoreLabel.text += str(Global.previous_game)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	get_tree().change_scene("res://Main.tscn")
