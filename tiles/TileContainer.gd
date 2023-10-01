extends Node2D

export var tile_scene: PackedScene
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal moved
signal game_end
signal no_moves

var line_started: bool = false
var tile_arr= []
var tile_child_arr=[]
var current_tiles = []
var cleared=0
var max_score=0

# Called when the node enters the scene tree for the first time.
func _ready():
	tile_arr = _create_map(6,6)
	max_score = 6*6
	tile_child_arr = _create_map(6,6)
	_reset_current_tiles()
	_set_tiles(6, 48, Global.level_selected)
	#print(tile_child_arr)
	

func _set_tiles(xy_tiles, tile_size, level):
	randomize()
	var current_x = 0
	var current_y = 0
	
	var random_range = 10 if (level == Global.LevelVariants.LEGACY_EASY 
		or level == Global.LevelVariants.STANDARD_EASY) else 100
	
	for n in xy_tiles:
		for m in xy_tiles:
			var value = randi() % random_range
			var loc = Vector2(n,m)
			var tile = tile_scene.instance()
			var x= m*tile_size
			var y= n*tile_size
			tile.set_position(Vector2(x,y))
			if(level == Global.LevelVariants.LEGACY_EASY or level == Global.LevelVariants.STANDARD_EASY):
				tile.set_tile(str(value), value,loc)
			else:
				tile.set_tile(Global.TileVariants.DEFAULT, value, loc)
			tile.connect("pressed", self, "_on_tile_pressed")
			$Container.add_child(tile)
			tile_arr[n][m] = value
			tile_child_arr[n][m] = tile.get_index()

func _on_tile_pressed(pos, location):
	if(!line_started):
		_start_line(pos)
		line_started = true
		current_tiles[0] = Vector2(location.x, location.y)
	else:
		_end_line(pos)
		line_started = false
		current_tiles[1] = Vector2(location.x, location.y)
	
func _start_line(pos:Vector2):
	var center_pos = Vector2(pos.x, pos.y)
	$LineRect.set_position(center_pos)
	$LineRect.set_size(Vector2(48,48))
	$LineRect.show()

func _create_map(w, h):
	var map = []
	for x in range(w):
		var col = []
		col.resize(h)
		map.append(col)
	return map

func _reset_current_tiles():
	current_tiles = [Vector2(0,0), Vector2(0,0)]

func _end_line(pos:Vector2):
	
	var before_pos = Vector2(pos.x, pos.y)
	var current_pos = $LineRect.rect_position
	var start_pos = Vector2(before_pos.x,before_pos.y)
	
	if(before_pos.y != current_pos.y):
		if(before_pos.x != current_pos.x):
			$LineRect.hide()
			_run_mistake()
			emit_signal("moved", false)
			return
	elif(before_pos.x != current_pos.x):
		if(before_pos.y != current_pos.y):
			$LineRect.hide()
			_run_mistake()
			emit_signal("moved", false)
			return

	if(before_pos.x > current_pos.x):
		start_pos.x = current_pos.x
		before_pos.x += 48
	else:
		current_pos.x += 48
		
	if(before_pos.y > current_pos.y):
		start_pos.y = current_pos.y
		before_pos.y += 48
	else:
		current_pos.y += 48
	
	var length_x = abs(current_pos.x - before_pos.x) 
	var length_y = abs(current_pos.y - before_pos.y)
	
	var final_l_x = $LineRect.rect_size.x if length_x == 0 else length_x
	var final_l_y = $LineRect.rect_size.y if length_y == 0 else length_y
	$LineRect.set_position(start_pos)
	$LineRect.set_size(Vector2(final_l_x, final_l_y))
	$LineTimer.start()



func _calc_tiles():
	#print(current_tiles)
	var row_direction = 1 if (current_tiles[1].x - current_tiles[0].x) > 0 else -1 #rigth
	var col_direction = 1 if (current_tiles[1].y - current_tiles[0].y) > 0 else -1 #down
	
	if(current_tiles[1].x == current_tiles[0].x):
		row_direction = 0
	elif(current_tiles[1].y == current_tiles[0].y):
		col_direction = 0
	
	var tiles_to_check = []
	
	#TILE CAPTURING
	
	if(row_direction == 0):
		var row = current_tiles[0].x
		var start = current_tiles[0].y
		var end = current_tiles[1].y
		
		if(start > end):
			end -= 1
		else:
			end+=1
			
		for n in range(start, end, col_direction):
			var check_tile = {loc= Vector2(row, n), val= tile_arr[row][n]}
			tiles_to_check.append(check_tile)
			
	elif(col_direction == 0):
		var column = current_tiles[0].y
		var start = current_tiles[0].x
		var end = current_tiles[1].x
		
		if(start > end):
			end -= 1
		else:
			end+=1
		
		for n in range(start, end, row_direction):
			var check_tile = {loc= Vector2(n,column), val= tile_arr[n][column]}
			tiles_to_check.append(check_tile)
	
	#TILE CHECKING
	
	var val_before = -1
	for n in range(tiles_to_check.size()):
		var tile_check_val = tiles_to_check[n].val
		if tile_check_val >= val_before:
			val_before = tile_check_val
		elif tile_check_val == -1:
			continue
		else:
			#print("bad")
			_run_mistake()
			emit_signal("moved", false)
			return
			
	var moved_combo = 0
	
	for n in range(tiles_to_check.size()):
		if(tiles_to_check[n].val == -1):
			continue
		var tile_check_x = tiles_to_check[n].loc.x
		var tile_check_y = tiles_to_check[n].loc.y
		$Container.get_child(tile_child_arr[tile_check_x][tile_check_y]).hide_tile()
		tile_arr[tile_check_x][tile_check_y] = -1
		cleared += 1
		moved_combo += 1
		
	emit_signal("moved", true, moved_combo)
	
	if(_check_if_moves() == false):
		emit_signal("no_moves")
	
	if(cleared == max_score):
		emit_signal("game_end")

func _on_LineTimer_timeout():
	$LineRect.hide()
	_calc_tiles()
	
func _run_mistake():
	$MistakeTimer.start()
	$MistakeRect.show()

func _check_if_moves():
	var rows = tile_arr.size()
	var cols = tile_arr[0].size()
	
	var prev_val = -1
	
	for n in rows:
		for m in cols:
			var curr_val = tile_arr[n][m]
			if(curr_val != -1 and prev_val != -1):
				return true
			if(m == cols-1):
				prev_val = -1
			else:
				prev_val = curr_val
		
	
	for m in cols:
		for n in rows:
			var curr_val = tile_arr[n][m]
			if(curr_val != -1 and prev_val != -1):
				return true
			if(n == rows -1):
				prev_val = -1
			else:
				prev_val = curr_val
			
	return false
	#for n in tile_arr.size()

func _on_MistakeTimer_timeout():
	$MistakeRect.hide()
	
func get_num_of_tiles_left():
	return max_score - cleared
