@tool
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

var edit_frame: Array = []

func _ready() -> void:
	if Engine.is_editor_hint():
		editor_sprite()
		return
	set_animations()
	set_frames()
## END of _ready


func set_frames() -> void:
	var tileframes: Array
	# Test Frame - [X Tile, Y Tile, X Flip, Y Flip, replace?]
	tileframes.push_back([0,0,false,false,true])
	frames.append_array(tileframes)
	tileframes.clear()
## END of set_frames


func set_animations() -> void:
	var animframes: Array
	# Test Animation - [frame 0, frame 1, frame 2, etc...]
	animframes.push_back([0,0,0])
	animations.append_array(animframes)
	animframes.clear()
## END of set_animations


func animate(anim) -> void:
	match anim:
		0: # Test Frame
			true_frame = animations[anim][0]
## END of animate


func editor_sprite() -> void:
	var tileframes: Array
	tileframes.push_back([0,0,false,false,true])
	edit_frame.append_array(tileframes)
	tileframes.clear()
## END of editor_sprite
