@tool
extends SpriteAnim

@export var spr_object: SpriteObject


func set_frames() -> void:
	var tileframes: Array
	# Brick Highlighted
	tileframes.push_back([5,8,false,false,true])
	tileframes.push_back([5,8,false,false,true])
	tileframes.push_back([6,8,false,false,true])
	tileframes.push_back([6,8,false,false,true])
	frames.append_array(tileframes)
	tileframes.clear()
	# Brick
	tileframes.push_back([6,8,false,false,true])
	tileframes.push_back([6,8,false,false,true])
	tileframes.push_back([6,8,false,false,true])
	tileframes.push_back([6,8,false,false,true])
	frames.append_array(tileframes)
	tileframes.clear()
	# Empty Block
	tileframes.push_back([7,8,false,false,true])
	tileframes.push_back([7,8,true,false,true])
	tileframes.push_back([7,8,false,true,true])
	tileframes.push_back([7,8,true,true,true])
	frames.append_array(tileframes)
	tileframes.clear()
## END of set_frames


func set_animations() -> void:
	var animframes: Array
	# Brick Highlighted
	animframes.push_back([0])
	animations.append_array(animframes)
	animframes.clear()
	# Brick
	animframes.push_back([1])
	animations.append_array(animframes)
	animframes.clear()
	# Empty Block
	animframes.push_back([2])
	animations.append_array(animframes)
	animframes.clear()
## END of set_animations


func animate(anim) -> void:
	match anim:
		0:
			true_frame = animations[anim][0]
		1:
			true_frame = animations[anim][0]
		2:
			true_frame = animations[anim][0]
	last_anim = anim
	spr_object.set_sprite()
## END of animate


func editor_sprite() -> void:
	var tileframes: Array
	tileframes.push_back([7,8,false,false])
	tileframes.push_back([7,8,true,false])
	tileframes.push_back([7,8,false,true])
	tileframes.push_back([7,8,true,true])
	edit_frame.append_array(tileframes)
	tileframes.clear()
## END 
