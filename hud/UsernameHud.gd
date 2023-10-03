extends CanvasLayer


signal success

# Called when the node enters the scene tree for the first time.
func _ready():
	_check_current_user()
	
func _check_current_user():
	var username = $SavesServiceNode.check_if_user_is_saved()
	if(username != ""):
		$ColorRect2/UserEdit.text = username

func _on_OkButton_pressed():
	var user_edit = $ColorRect2/UserEdit.text
	if(user_edit.length() == 0 or user_edit.find(" ") != -1):
		$ColorRect2/ErrorLabel.show()
		$ColorRect2/UserEdit.text = ""
	else:
		$SavesServiceNode.save_user(user_edit)
		$ColorRect2/ErrorLabel.hide()
		emit_signal("success", user_edit)
