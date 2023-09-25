extends Control


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
