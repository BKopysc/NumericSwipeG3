extends Control

signal game_paused
signal game_exit

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func update_move(move_ctr):
	$CanvasLayer/HBoxContainer2/MoveLabel.text = move_ctr

func update_timer(time_count):
	var minutes = floor(time_count/60)
	var seconds = time_count-minutes*60
	
	var minutes_label = "0"+str(minutes) if minutes < 10 else ""+str(minutes)
	var second_label = "0"+str(seconds) if seconds < 10 else "" + str(seconds)
	
	$CanvasLayer/HBoxContainer/TimeLabel.text = minutes_label + ":" + second_label


func _on_button_pressed():
	$PauseHud.show()
	game_paused.emit(true)


func _on_pause_hud_resume_pressed():
	$PauseHud.hide()
	game_paused.emit(false)
	

func _on_pause_hud_exit_pressed():
	game_exit.emit()
