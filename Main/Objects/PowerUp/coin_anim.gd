@tool
extends SpriteAnim


func set_frames() -> void:
	var tileframes: Array
	tileframes.push_back([0,6,false,false,true])
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([0,6,false,true,true])
	tileframes.push_back([12,15,false,false,true])
	frames.append_array(tileframes)
	tileframes.clear()
	tileframes.push_back([1,6,false,false,true])
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([1,6,false,true,true])
	tileframes.push_back([12,15,false,false,true])
	frames.append_array(tileframes)
	tileframes.clear()
	tileframes.push_back([2,6,false,false,true])
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([2,6,false,true,true])
	tileframes.push_back([12,15,false,false,true])
	frames.append_array(tileframes)
	tileframes.clear()
	tileframes.push_back([3,6,false,false,true])
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([3,6,false,true,true])
	tileframes.push_back([12,15,false,false,true])
	frames.append_array(tileframes)
	tileframes.clear()
## END of set_frames


func set_animations() -> void:
	var animframes: Array
	animframes.push_back([0,1,2,3])
	animations.append_array(animframes)
	animframes.clear()
## END of set_animations


func animate(anim) -> void:
	frame_timer += 1
	if frame_timer >= 2:
		frame_timer = 0
		fake_frame += 1
		if fake_frame >= 4:
			fake_frame = 0
	true_frame = animations[anim][fake_frame]
	last_anim = anim
	spr_object.set_sprite()
## END of animate


func editor_sprite() -> void:
	var tileframes: Array
	tileframes.push_back([0,6,false,false,true])
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([0,6,false,true,true])
	tileframes.push_back([12,15,false,false,true])
	edit_frame.append_array(tileframes)
	tileframes.clear()
## END of editor_sprite
