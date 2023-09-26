extends Control

var variant: String
var value: int
var location = Vector2(0,0)
var disabled_tile = false

signal pressed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	


func set_tile(n_variant: String, n_value: int, n_location: Vector2):
	
	variant = n_variant
	value = n_value
	$TileTexture/TileLabel.text = str(value)
	location.x = n_location.x
	location.y = n_location.y
	
	match (n_variant):
		Global.TileVariants.BLANK:
			$TileTexture.texture = preload("res://assets/tiles/blank.png")
		Global.TileVariants.DEFAULT:
			$TileTexture.texture = preload("res://assets/tiles/default.png")
		Global.TileVariants.ZERO:
			$TileTexture.texture = preload("res://assets/tiles/tile0.png")
		Global.TileVariants.ONE:
			$TileTexture.texture = preload("res://assets/tiles/tile1.png")
		Global.TileVariants.TWO:
			$TileTexture.texture = preload("res://assets/tiles/tile2.png")
		Global.TileVariants.THREE:
			$TileTexture.texture = preload("res://assets/tiles/tile3.png")
		Global.TileVariants.FOUR:
			$TileTexture.texture = preload("res://assets/tiles/tile4.png")
		Global.TileVariants.FIVE:
			$TileTexture.texture = preload("res://assets/tiles/tile5.png")
		Global.TileVariants.SIX:
			$TileTexture.texture = preload("res://assets/tiles/tile6.png")
		Global.TileVariants.SEVEN:
			$TileTexture.texture = preload("res://assets/tiles/tile7.png")
		Global.TileVariants.EIGHT:
			$TileTexture.texture = preload("res://assets/tiles/tile8.png")
		Global.TileVariants.NINE:
			$TileTexture.texture = preload("res://assets/tiles/tile9.png")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_SimpleTile_mouse_entered():
	if(!$HoverTexture.visible):
		$HoverTexture.show()
	

func _on_SimpleTile_mouse_exited():
	$HoverTexture.hide()
	$SelectedTexture.hide()


func _on_SimpleTile_gui_input(event):
	if(event is InputEventMouseButton and event.pressed):
		$SelectedTexture.show()
		emit_signal("pressed", self.rect_position, self.location)
	elif(event is InputEventMouseMotion):
		if(!$HoverTexture.visible):
			$HoverTexture.show()
			

func hide_tile():
	$TileTexture/TileLabel.hide()
	$TileTexture.texture = preload("res://assets/tiles/blank.png")
	disabled_tile = true
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	mouse_default_cursor_shape = Control.CURSOR_ARROW
