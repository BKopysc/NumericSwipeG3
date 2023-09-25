extends Node2D


var variant: String
var value: int
var location = {x=0,y=0}


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func set_variant(n_variant: String):
	match (Global.TileVariants.keys()):
		Global.TileVariants.BLANK:
			print("blank")
		Global.TileVariants.DEFAULT:
			print("default")
		Global.TileVariants.ONE:
			print("one")
		Global.TileVariants.TWO:
			print("TWO")
		Global.TileVariants.THREE:
			print("THREE")
		Global.TileVariants.FOUR:
			print("FOUR")
		Global.TileVariants.FIVE:
			print("one")
		Global.TileVariants.SIX:
			print("one")
		Global.TileVariants.SEVEN:
			print("one")
		Global.TileVariants.EIGHT:
			print("one")
		Global.TileVariants.NINE:
			print("one")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
