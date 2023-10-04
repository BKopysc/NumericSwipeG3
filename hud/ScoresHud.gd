extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


const TAB_LEGACY_SCORES = {
	"0": Global.LevelVariants.LEGACY_FIRST,
	"1": Global.LevelVariants.LEGACY_FIRST,
	"2": Global.LevelVariants.LEGACY_HARD,
}

const TAB_STANDARD_SCORES = {
	"0": Global.LevelVariants.STANDARD_EASY,
	"1": Global.LevelVariants.STANDARD_HARD
}

const TAB_GLOBAL = {
	"0" : "LEGACY",
	"1": "STANDARD"
}

# Called when the node enters the scene tree for the first time.
func _ready():
	#load_current_tab("LEGACY")
	pass


func load_current_tab(score_type):
	var current_tab = $CanvasLayer/TabContainer.get_current_tab_control().get_current_tab_control()
	var id = current_tab.get_index()
	var global_tab_id = $CanvasLayer/TabContainer.get_current_tab_control().get_index()
	var level_type = ""
	TAB_GLOBAL[0]
	match score_type:
		"STANDARD":
			level_type = TAB_STANDARD_SCORES[id]
		"LEGACY":
			level_type = TAB_LEGACY_SCORES[id]
	
	current_tab.get_child(0).load_user_score(1, "bart", randi()%100)
	
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Legacy_tab_changed(tab):
	#load_current_tab()
	pass

func _on_Standard_tab_changed(tab):
	#load_current_tab()
	pass


func _on_TabContainer_tab_changed(tab):
	if(tab == 1):
		$CanvasLayer/TabContainer/Legacy.current_tab = 0
	else:
		$CanvasLayer/TabContainer/Standard.current_tab = 0
