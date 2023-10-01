extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$ColorRectLegacy/LegacyMenu.get_popup().add_font_override("font", preload("res://font-micra-small.tres"))
	#$ColorRectLegacy/LegacyMenu.get_popup().rect_min_size = Vector2(200,50)
	$ColorRectLegacy/LegacyMenu.get_popup().add_constant_override("vseparation", 30)
	$ColorRectLegacy/LegacyMenu.get_popup().add_item("Easy",Global.LevelVariants.LEGACY_EASY)
	$ColorRectLegacy/LegacyMenu.get_popup().add_item("Hard",Global.LevelVariants.LEGACY_HARD)
	$ColorRectLegacy/LegacyMenu.get_popup().connect("id_pressed", self, "_popup_action")
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _popup_action(id):
	_change_scene(id)



func _change_scene(level_opt):
	Global.set_level(level_opt)
	get_tree().change_scene("res://levels/DefaultLevel.tscn")



func _on_EasyStandardButton_pressed():
	_change_scene(Global.LevelVariants.STANDARD_EASY)


func _on_HardStandardButton_pressed():
	_change_scene(Global.LevelVariants.STANDARD_HARD)


func _on_BackButton_pressed():
	get_tree().change_scene("res://Main.tscn")
