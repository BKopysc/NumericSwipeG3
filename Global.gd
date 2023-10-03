extends Node2D

var level_selected = LevelVariants.STANDARD_EASY
var session_high_score = 1000000
var previous_game = 0
var previous_timer_ctr = 0
var previous_move_ctr = 0
var previous_skip_ctr = 0
var is_high_score = false

var is_music = true
var is_sound = true

const light_theme = {background = "#5180cc", text = "white"}
const dark_theme = {background = "#22222f", text = "gray"}
var active_theme = light_theme

const TileVariants = {
	BLANK = "blank",
	DEFAULT = "default",
	ZERO = "0",
	ONE = "1",
	TWO = "2",
	THREE = "3",
	FOUR = "4",
	FIVE = "5",
	SIX = "6",
	SEVEN = "7",
	EIGHT = "8",
	NINE = "9"
	}
	
enum LevelVariants{
	LEGACY_FIRST,
	LEGACY_EASY,
	LEGACY_HARD,
	STANDARD_EASY,
	STANDARD_HARD
}

const min_score_multiplier = 20
const skip_score_val = 200
const time_score_multiplier = 20 
const hard_game_multiplier = 0.7

const ScorePoints = {
	2: 10*min_score_multiplier,
	3: 4*min_score_multiplier,
	4: 2*min_score_multiplier,
	5: 1*min_score_multiplier,
	6: 0
}

func toggle_theme():
	if(active_theme == light_theme):
		active_theme = dark_theme
	else:
		active_theme = light_theme

func set_previous_game(timer_ctr, move_ctr, skip_ctr, score):
	previous_game = score
	previous_move_ctr = move_ctr
	previous_timer_ctr = timer_ctr
	previous_skip_ctr = skip_ctr
	if(score < session_high_score):
		session_high_score = score
		is_high_score = true

func disable_high_score_flag():
	is_high_score = false


func getTileVariants():
	return TileVariants

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func toggle_sound():
	is_sound = !is_sound
	return is_sound
	
func play_correct():
	if(is_sound):
		$CorrectTileSound.play()
	

func play_end():
	if(is_sound):
		$EndGameSound.play()
	
func play_invalid():
	if(is_sound):
		$InvalidTileSound.play()
		
func play_tile_sound(state):
	if(state):
		play_correct()
	else:
		play_invalid()

func toggle_music():
	is_music = !is_music
	$GlobalMusic.playing = is_music
	return is_music

func set_level(level):
	level_selected = level

func get_level():
	return level_selected
