extends Control

signal game_paused
signal game_exited
signal game_skipped

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func update_timer(time_count):
	var minutes = floor(time_count/60)
	var seconds = time_count-minutes*60
	
	var minutes_label = "0"+str(minutes) if minutes < 10 else ""+str(minutes)
	var second_label = "0"+str(seconds) if seconds < 10 else "" + str(seconds)
	
	$CanvasLayer/HBoxContainerTimer/TimeLabel.text = minutes_label + ":" + second_label

func _on_PauseButton_pressed():
	$PauseHud.show()
	emit_signal("game_paused", true)


func _on_PauseHud_exit_pressed():
	$PauseHud.hide()
	emit_signal("game_exited")
	


func _on_PauseHud_resume_pressed():
	$PauseHud.hide()
	emit_signal("game_paused", false)



func _on_Button_pressed():
	emit_signal("game_skipped")
