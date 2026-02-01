extends Node
class_name SpriteAnim

var frames: Array = []


func _ready() -> void:
	set_frames()
## END of _ready


func set_frames() -> void:
	var tileframes: Array
	# Test Frame - [X Tile, Y Tile, X Flip, Y Flip]
	tileframes.push_back([0,0,false,false])
	frames.push_back(tileframes)
## END of set_frames
