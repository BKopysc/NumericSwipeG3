extends Node2D

export var tile_scene: PackedScene
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var line_started: bool = false

var tile_arr= []
var current_tiles = []

# Called when the node enters the scene tree for the first time.
func _ready():
	tile_arr = _create_map(6,6)
	_reset_current_tiles()
	set_tiles(6, 48)

func set_tiles(xy_tiles, tile_size):
	var current_x = 0
	var current_y = 0
	
	for n in xy_tiles:
		for m in xy_tiles:
			var value = randi() % 10
			var loc = Vector2(n,m)
			var tile = tile_scene.instance()
			var x= m*tile_size
			var y= n*tile_size
			tile.set_position(Vector2(x,y))
			tile.set_tile(str(value), value,loc)
			tile.connect("pressed", self, "_on_tile_pressed")
			$Container.add_child(tile)
			tile_arr[n][m] = value
			
			

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
			return
	elif(before_pos.x != current_pos.x):
		if(before_pos.y != current_pos.y):
			$LineRect.hide()
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


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _calc_tiles():
	print(current_tiles)


func _on_LineTimer_timeout():
	$LineRect.hide()
	_calc_tiles()
	

