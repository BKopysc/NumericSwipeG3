extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _check_system_persistent():
	return OS.is_userfs_persistent()

func check_if_user_is_saved():
	if not _check_system_persistent():
		return ""
	
	var save = File.new()
	var path = Global.FileName.username
	
	if not save.file_exists(path):
		return ""
		
	save.open(path, File.READ)
	var username = save.get_line()
	save.close()
	
	return username
	
func save_user(username):
	var save = File.new()
	var path = Global.FileName.username
	save.open(path, File.WRITE)
	save.store_string(username)
	save.close()
	
	if(check_if_user_is_saved() == username):
		print(username)
		return true
	else:
		return false
	
	
	

