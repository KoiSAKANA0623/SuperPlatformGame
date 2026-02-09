@tool
extends SpriteAnim


func set_frames() -> void:
	var tileframes: Array
	# Super Mushroom
	tileframes.push_back([6,7,false,false,true])
	tileframes.push_back([7,7,false,false,true])
	tileframes.push_back([8,7,false,false,true])
	tileframes.push_back([9,7,false,false,true])
	frames.append_array(tileframes)
	tileframes.clear()
	# Fire Flower
	tileframes.push_back([6,13,false,false,true])
	tileframes.push_back([6,13,true,false,true])
	tileframes.push_back([9,13,false,false,true])
	tileframes.push_back([9,13,true,false,true])
	frames.append_array(tileframes)
	tileframes.clear()
	# Starman
	tileframes.push_back([13,8,false,false,true])
	tileframes.push_back([13,8,true,false,true])
	tileframes.push_back([4,14,false,false,true])
	tileframes.push_back([4,14,true,false,true])
	frames.append_array(tileframes)
	tileframes.clear()
## END of set_frames


func set_animations() -> void:
	var animframes: Array
	# Test Animation - [frame 0, frame 1, frame 2, etc...]
	animframes.push_back([0])
	animations.append_array(animframes)
	animframes.clear()
	animframes.push_back([1])
	animations.append_array(animframes)
	animframes.clear()
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
	tileframes.push_back([6,7,false,false])
	tileframes.push_back([7,7,false,false])
	tileframes.push_back([8,7,false,false])
	tileframes.push_back([9,7,false,false])
	edit_frame.append_array(tileframes)
	tileframes.clear()
## END of editor_sprite
