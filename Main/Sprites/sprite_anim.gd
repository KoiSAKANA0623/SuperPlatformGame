extends Node
class_name SpriteAnim

var frames: Array = []
var animations: Array = []

var last_anim: int = 0
var true_frame: int = 0
var fake_frame: int = 0
var frame_timer: int = 0
var EXfake_frame: int = 0
var EXframe_timer: int = 0
var anim_speed: int = 7


func _ready() -> void:
	set_animations()
	set_frames()
## END of _ready


func set_frames() -> void:
	var tileframes: Array
	# Test Frame - [X Tile, Y Tile, X Flip, Y Flip, replace?]
	tileframes.push_back([0,0,false,false,true])
	frames.push_back(tileframes)
	tileframes.clear()
## END of set_frames


func set_animations() -> void:
	var animframes: Array
	# Test Animation - [frame 0, frame 1, frame 2, etc...]
	animframes.push_back([0,0,0])
	animations.push_back(animframes)
	animframes.clear()
## END of set_animations


func animate(anim) -> void:
	match anim:
		0: # Test Frame
			true_frame = animations[anim][0]
## END of animate
