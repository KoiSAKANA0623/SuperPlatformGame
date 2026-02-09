@tool
extends SpriteAnim

# 0 = SM Idle
# 1 = SM Walk 0
# 2 = SM Walk 1
# 3 = SM Walk 2
# 4 = SM Skid
# 5 = SM Jump
# 6 = SM Death
# 7 = SM Climb 0
# 8 = SM Climb 1
# 9 = SM Swim 0
# 10 = SM Swim 1
# 11 = SM Swim 2
# 12 = SM SwimPad 0
# 13 = SM SwimPad 1
# 14 = BM Idle
# 15 = BM Walk 0
# 16 = BM Walk 1
# 17 = BM Walk 2
# 18 = BM Skid
# 19 = BM Jump
# 20 = BM Duck
# 21 = BM Climb 0
# 22 = BM Climb 1
# 23 = BM Swim 0
# 24 = BM Swim 1
# 25 = BM Swim 2
# 26 = BM SwimPad 0
# 27 = BM SwimPad 1
# 28 = FM Fireball Idle
# 29 = FM Fireball Change
# 30 = Growing Mario

func set_frames() -> void:
	var tileframes: Array
# Small Mario
	# SM Idle
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([10,3,false,false,true])
	tileframes.push_back([7,3,false,false,true])
	tileframes.push_back([15,4,false,false,true])
	tileframes.push_back([15,4,true,false,true])
	frames.append_array(tileframes)
	tileframes.clear()
	# SM Walk 0
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([6,3,false,false,true])
	tileframes.push_back([7,3,false,false,true])
	tileframes.push_back([8,3,false,false,true])
	tileframes.push_back([9,3,false,false,true])
	frames.append_array(tileframes)
	tileframes.clear()
	# SM Walk 1
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([10,3,false,false,true])
	tileframes.push_back([7,3,false,false,true])
	tileframes.push_back([11,3,false,false,true])
	tileframes.push_back([12,3,false,false,true])
	frames.append_array(tileframes)
	tileframes.clear()
	# SM Walk 2
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([2,3,false,false,true])
	tileframes.push_back([3,3,false,false,true])
	tileframes.push_back([4,3,false,false,true])
	tileframes.push_back([5,3,false,false,true])
	frames.append_array(tileframes)
	tileframes.clear()
	# SM Skid
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([13,3,false,false,true])
	tileframes.push_back([14,3,false,false,true])
	tileframes.push_back([15,3,false,false,true])
	tileframes.push_back([0,4,false,false,true])
	frames.append_array(tileframes)
	tileframes.clear()
	# SM Jump
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([2,3,false,false,true])
	tileframes.push_back([1,4,false,false,true])
	tileframes.push_back([2,4,false,false,true])
	tileframes.push_back([3,4,false,false,true])
	frames.append_array(tileframes)
	tileframes.clear()
	# SM Death
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([14,9,false,false,true])
	tileframes.push_back([14,9,true,false,true])
	tileframes.push_back([15,9,false,false,true])
	tileframes.push_back([15,9,true,false,true])
	frames.append_array(tileframes)
	tileframes.clear()
	# SM Climb 0
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([2,3,false,false,true])
	tileframes.push_back([3,3,false,false,true])
	tileframes.push_back([0,9,false,false,true])
	tileframes.push_back([1,9,false,false,true])
	frames.append_array(tileframes)
	tileframes.clear()
	# SM Climb 1
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([10,3,false,false,true])
	tileframes.push_back([7,3,false,false,true])
	tileframes.push_back([2,9,false,false,true])
	tileframes.push_back([3,9,false,false,true])
	frames.append_array(tileframes)
	tileframes.clear()
	# SM Swim 0
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([2,3,false,false,true])
	tileframes.push_back([3,3,false,false,true])
	tileframes.push_back([4,4,false,false,true])
	tileframes.push_back([5,4,false,false,true])
	frames.append_array(tileframes)
	tileframes.clear()
	# SM Swim 1
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([2,3,false,false,true])
	tileframes.push_back([3,3,false,false,true])
	tileframes.push_back([0,0,false,false,true])
	tileframes.push_back([7,4,false,false,true])
	frames.append_array(tileframes)
	tileframes.clear()
	# SM Swim 2
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([2,3,false,false,true])
	tileframes.push_back([3,3,false,false,true])
	tileframes.push_back([8,4,false,false,true])
	tileframes.push_back([9,4,false,false,true])
	frames.append_array(tileframes)
	tileframes.clear()
	# SM SwimPad 0
	tileframes.push_back([0,0,false,false,false])
	tileframes.push_back([0,0,false,false,false])
	tileframes.push_back([0,0,false,false,false])
	tileframes.push_back([0,0,false,false,false])
	tileframes.push_back([0,0,false,false,false])
	tileframes.push_back([0,0,false,false,false])
	tileframes.push_back([4,4,false,false,true])
	tileframes.push_back([0,0,false,false,false])
	frames.append_array(tileframes)
	tileframes.clear()
	# SM SwimPad 1
	tileframes.push_back([0,0,false,false,false])
	tileframes.push_back([0,0,false,false,false])
	tileframes.push_back([0,0,false,false,false])
	tileframes.push_back([0,0,false,false,false])
	tileframes.push_back([0,0,false,false,false])
	tileframes.push_back([0,0,false,false,false])
	tileframes.push_back([6,4,false,false,true])
	tileframes.push_back([0,0,false,false,false])
	frames.append_array(tileframes)
	tileframes.clear()
# Big Mario
	# BM Idle
	tileframes.push_back([0,0,false,false,true])
	tileframes.push_back([1,0,false,false,true])
	tileframes.push_back([12,4,false,false,true])
	tileframes.push_back([13,4,false,false,true])
	tileframes.push_back([10,4,false,false,true])
	tileframes.push_back([10,4,true,false,true])
	tileframes.push_back([11,4,false,false,true])
	tileframes.push_back([11,4,true,false,true])
	frames.append_array(tileframes)
	tileframes.clear()
	# BM Walk 0
	tileframes.push_back([8,0,false,false,true])
	tileframes.push_back([9,0,false,false,true])
	tileframes.push_back([10,0,false,false,true])
	tileframes.push_back([11,0,false,false,true])
	tileframes.push_back([12,0,false,false,true])
	tileframes.push_back([13,0,false,false,true])
	tileframes.push_back([14,0,false,false,true])
	tileframes.push_back([15,0,false,false,true])
	frames.append_array(tileframes)
	tileframes.clear()
	# BM Walk 1
	tileframes.push_back([0,1,false,false,true])
	tileframes.push_back([1,1,false,false,true])
	tileframes.push_back([2,1,false,false,true])
	tileframes.push_back([3,1,false,false,true])
	tileframes.push_back([4,1,false,false,true])
	tileframes.push_back([5,1,false,false,true])
	tileframes.push_back([6,1,false,false,true])
	tileframes.push_back([7,1,false,false,true])
	frames.append_array(tileframes)
	tileframes.clear()
	# BM Walk 2
	tileframes.push_back([0,0,false,false,true])
	tileframes.push_back([1,0,false,false,true])
	tileframes.push_back([2,0,false,false,true])
	tileframes.push_back([3,0,false,false,true])
	tileframes.push_back([4,0,false,false,true])
	tileframes.push_back([5,0,false,false,true])
	tileframes.push_back([6,0,false,false,true])
	tileframes.push_back([7,0,false,false,true])
	frames.append_array(tileframes)
	tileframes.clear()
	# BM Skid
	tileframes.push_back([8,1,false,false,true])
	tileframes.push_back([9,1,false,false,true])
	tileframes.push_back([10,1,false,false,true])
	tileframes.push_back([11,1,false,false,true])
	tileframes.push_back([12,1,false,false,true])
	tileframes.push_back([13,1,false,false,true])
	tileframes.push_back([14,1,false,false,true])
	tileframes.push_back([15,1,false,false,true])
	frames.append_array(tileframes)
	tileframes.clear()
	# BM Jump
	tileframes.push_back([0,2,false,false,true])
	tileframes.push_back([1,2,false,false,true])
	tileframes.push_back([2,2,false,false,true])
	tileframes.push_back([3,2,false,false,true])
	tileframes.push_back([4,2,false,false,true])
	tileframes.push_back([5,2,false,false,true])
	tileframes.push_back([6,2,false,false,true])
	tileframes.push_back([7,2,false,false,true])
	frames.append_array(tileframes)
	tileframes.clear()
	# BM Duck
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([8,0,false,false,true])
	tileframes.push_back([9,0,false,false,true])
	tileframes.push_back([8,5,false,false,true])
	tileframes.push_back([9,5,false,false,true])
	tileframes.push_back([10,5,false,false,true])
	tileframes.push_back([10,5,true,false,true])
	frames.append_array(tileframes)
	tileframes.clear()
	# BM Climb 0
	tileframes.push_back([8,0,false,false,true])
	tileframes.push_back([9,0,false,false,true])
	tileframes.push_back([8,2,false,false,true])
	tileframes.push_back([9,2,false,false,true])
	tileframes.push_back([10,2,false,false,true])
	tileframes.push_back([11,2,false,false,true])
	tileframes.push_back([12,5,false,false,true])
	tileframes.push_back([13,5,false,false,true])
	frames.append_array(tileframes)
	tileframes.clear()
	# BM Climb 1
	tileframes.push_back([8,0,false,false,true])
	tileframes.push_back([9,0,false,false,true])
	tileframes.push_back([10,0,false,false,true])
	tileframes.push_back([11,0,false,false,true])
	tileframes.push_back([12,0,false,false,true])
	tileframes.push_back([13,0,false,false,true])
	tileframes.push_back([14,5,false,false,true])
	tileframes.push_back([15,5,false,false,true])
	frames.append_array(tileframes)
	tileframes.clear()
	# BM Swim 0
	tileframes.push_back([8,0,false,false,true])
	tileframes.push_back([9,0,false,false,true])
	tileframes.push_back([8,2,false,false,true])
	tileframes.push_back([9,2,false,false,true])
	tileframes.push_back([10,2,false,false,true])
	tileframes.push_back([11,2,false,false,true])
	tileframes.push_back([12,2,false,false,true])
	tileframes.push_back([13,2,false,false,true])
	frames.append_array(tileframes)
	tileframes.clear()
	# BM Swim 1
	tileframes.push_back([8,0,false,false,true])
	tileframes.push_back([9,0,false,false,true])
	tileframes.push_back([10,0,false,false,true])
	tileframes.push_back([11,0,false,false,true])
	tileframes.push_back([12,0,false,false,true])
	tileframes.push_back([0,3,false,false,true])
	tileframes.push_back([0,0,false,false,true])
	tileframes.push_back([13,2,false,false,true])
	frames.append_array(tileframes)
	tileframes.clear()
	# BM Swim 2
	tileframes.push_back([8,0,false,false,true])
	tileframes.push_back([9,0,false,false,true])
	tileframes.push_back([10,0,false,false,true])
	tileframes.push_back([11,0,false,false,true])
	tileframes.push_back([14,2,false,false,true])
	tileframes.push_back([15,2,false,false,true])
	tileframes.push_back([0,0,false,false,true])
	tileframes.push_back([13,2,false,false,true])
	frames.append_array(tileframes)
	tileframes.clear()
	# BM SwimPad 0
	tileframes.push_back([0,0,false,false,false])
	tileframes.push_back([0,0,false,false,false])
	tileframes.push_back([0,0,false,false,false])
	tileframes.push_back([0,0,false,false,false])
	tileframes.push_back([0,0,false,false,false])
	tileframes.push_back([0,0,false,false,false])
	tileframes.push_back([12,2,false,false,true])
	tileframes.push_back([0,0,false,false,false])
	frames.append_array(tileframes)
	tileframes.clear()
	# BM SwimPad 1
	tileframes.push_back([0,0,false,false,false])
	tileframes.push_back([0,0,false,false,false])
	tileframes.push_back([0,0,false,false,false])
	tileframes.push_back([0,0,false,false,false])
	tileframes.push_back([0,0,false,false,false])
	tileframes.push_back([0,0,false,false,false])
	tileframes.push_back([1,3,false,false,true])
	tileframes.push_back([0,0,false,false,false])
	frames.append_array(tileframes)
	tileframes.clear()
# Fire Mario
	# FM Fireball Idle
	tileframes.push_back([8,0,false,false,true])
	tileframes.push_back([9,0,false,false,true])
	tileframes.push_back([8,2,false,false,true])
	tileframes.push_back([9,2,false,false,true])
	tileframes.push_back([10,2,false,false,true])
	tileframes.push_back([11,2,false,false,true])
	tileframes.push_back([14,0,false,false,true])
	tileframes.push_back([15,0,false,false,true])
	frames.append_array(tileframes)
	tileframes.clear()
	# FM Fireball Change
	tileframes.push_back([8,0,false,false,true])
	tileframes.push_back([9,0,false,false,true])
	tileframes.push_back([8,2,false,false,true])
	tileframes.push_back([9,2,false,false,true])
	tileframes.push_back([10,2,false,false,true])
	tileframes.push_back([11,2,false,false,true])
	tileframes.push_back([0,0,false,false,false])
	tileframes.push_back([0,0,false,false,false])
	frames.append_array(tileframes)
	tileframes.clear()
# Growing Mario
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([12,15,false,false,true])
	tileframes.push_back([0,0,false,false,true])
	tileframes.push_back([1,0,false,false,true])
	tileframes.push_back([12,4,false,false,true])
	tileframes.push_back([13,4,false,false,true])
	tileframes.push_back([14,4,false,false,true])
	tileframes.push_back([14,4,true,false,true])
	frames.append_array(tileframes)
	tileframes.clear()
## END of set_frames


# 0 = NULL
# 1 = SM Idle
# 2 = SM Walk
# 3 = SM Skid
# 4 = SM Jump
# 5 = SM Death
# 6 = SM Climb
# 7 = SM Swim Idle
# 8 = SM Swim Float
# 9 = SM Swim Paddle
# 10 = BM Idle
# 11 = BM Walk
# 12 = BM Skid
# 13 = BM Jump
# 14 = BM Duck
# 15 = BM Climb
# 16 = BM Swim Idle
# 17 = BM Swim Float
# 18 = BM Swim Paddle
# 19 = Fireball Idle
# 20 = Fireball Move


func set_animations() -> void:
	var animframes: Array
# Small Mario
	# NULL
	animframes.push_back([30])
	animations.append_array(animframes)
	animframes.clear()
	# SM Idle
	animframes.push_back([0])
	animations.append_array(animframes)
	animframes.clear()
	# SM Walk
	animframes.push_back([3,1,2,3])
	animations.append_array(animframes)
	animframes.clear()
	# SM Skid
	animframes.push_back([4])
	animations.append_array(animframes)
	animframes.clear()
	# SM Jump
	animframes.push_back([5])
	animations.append_array(animframes)
	animframes.clear()
	# SM Death
	animframes.push_back([6])
	animations.append_array(animframes)
	animframes.clear()
	# SM Climb
	animframes.push_back([7,8])
	animations.append_array(animframes)
	animframes.clear()
	# SM Swim Idle
	animframes.push_back([9])
	animations.append_array(animframes)
	animframes.clear()
	# SM Swim Float
	animframes.push_back([10,11,9,10,11,9,10,11,9])
	animations.append_array(animframes)
	animframes.clear()
	# SM Swim Paddle
	animframes.push_back([12,13])
	animations.append_array(animframes)
	animframes.clear()
	# BM Idle
	animframes.push_back([14])
	animations.append_array(animframes)
	animframes.clear()
	# BM Walk
	animframes.push_back([17,15,16,17])
	animations.append_array(animframes)
	animframes.clear()
	# BM Skid
	animframes.push_back([18])
	animations.append_array(animframes)
	animframes.clear()
	# BM Jump
	animframes.push_back([19])
	animations.append_array(animframes)
	animframes.clear()
	# BM Duck
	animframes.push_back([20])
	animations.append_array(animframes)
	animframes.clear()
	# BM Climb
	animframes.push_back([21,22])
	animations.append_array(animframes)
	animframes.clear()
	# BM Swim Idle
	animframes.push_back([23])
	animations.append_array(animframes)
	animframes.clear()
	# BM Swim Float
	animframes.push_back([24,25,23,24,25,23])
	animations.append_array(animframes)
	animframes.clear()
	# BM Swim Paddle
	animframes.push_back([26,27])
	animations.append_array(animframes)
	animframes.clear()
	# Fireball Idle
	animframes.push_back([28])
	animations.append_array(animframes)
	animframes.clear()
	# Fireball Move
	animframes.push_back([29])
	animations.append_array(animframes)
	animframes.clear()
	# Growing
	animframes.push_back([0,30,0,30,14,0,30,14,0,14,14])
	animations.append_array(animframes)
	animframes.clear()
	# Shrinking
	animframes.push_back([23,9,23,9,23,9,23,9,23,9])
	animations.append_array(animframes)
	animframes.clear()
## END of animate


func animate(anim) -> void:
	if anim != last_anim:
		fake_frame = 0
		frame_timer = 0
	match anim:
		0: # Null
			true_frame = animations[anim][0]
		1: # SM Idle
			true_frame = animations[anim][0]
		2: # SM Walk
			if anim_speed:
				frame_timer += 1
				if fake_frame == 0:
					if frame_timer >= 2:
						frame_timer = 0
						fake_frame += 1
				else:
					if frame_timer >= anim_speed:
						frame_timer = 0
						fake_frame += 1
						if fake_frame >= 4:
							fake_frame = 1
			true_frame = animations[anim][fake_frame]
		3: # SM Skid
			true_frame = animations[anim][0]
		4: # SM Jump
			true_frame = animations[anim][0]
		5: # SM Death
			true_frame = animations[anim][0]
		6: # SM Climb
			frame_timer += 1
			if frame_timer >= 8:
				frame_timer = 0
				fake_frame += 1
				if fake_frame >= 2:
					fake_frame = 0
			true_frame = animations[anim][fake_frame]
		7: # SM Swim Idle
			true_frame = animations[anim][0]
			spr_object.set_sprite()
			EXframe_timer += 1
			if EXframe_timer >= 4:
				EXframe_timer = 0
				EXfake_frame += 1
				if EXfake_frame >= 2:
					EXfake_frame = 0
			true_frame = animations[9][EXfake_frame]
		8: # SM Swim Float
			frame_timer += 1
			if frame_timer >= 4:
				frame_timer = 0
				fake_frame += 1
				if fake_frame >= 9:
					fake_frame = 0
			true_frame = animations[anim][fake_frame]
			if true_frame != 11:
				spr_object.set_sprite()
				EXframe_timer += 1
				if EXframe_timer >= 4:
					EXframe_timer = 0
					EXfake_frame += 1
					if EXfake_frame >= 2:
						EXfake_frame = 0
				true_frame = animations[9][EXfake_frame]
		10: # BM Idle
			true_frame = animations[anim][0]
		11: # BM Walk
			if anim_speed:
				frame_timer += 1
				if fake_frame == 0:
					if frame_timer >= 2:
						frame_timer = 0
						fake_frame += 1
				else:
					if frame_timer >= anim_speed:
						frame_timer = 0
						fake_frame += 1
						if fake_frame >= 4:
							fake_frame = 1
			true_frame = animations[anim][fake_frame]
		12: # BM Skid
			true_frame = animations[anim][0]
		13: # BM Jump
			true_frame = animations[anim][0]
		14: # BM Death
			true_frame = animations[anim][0]
		15: # BM Climb
			frame_timer += 1
			if frame_timer >= 8:
				frame_timer = 0
				fake_frame += 1
				if fake_frame >= 2:
					fake_frame = 0
			true_frame = animations[anim][fake_frame]
		16: # BM Swim Idle
			true_frame = animations[anim][0]
			spr_object.set_sprite()
			EXframe_timer += 1
			if EXframe_timer >= 4:
				EXframe_timer = 0
				EXfake_frame += 1
				if EXfake_frame >= 2:
					EXfake_frame = 0
			true_frame = animations[18][EXfake_frame]
		17: # BM Swim Float
			frame_timer += 1
			if frame_timer >= 7:
				frame_timer = 0
				fake_frame += 1
				if fake_frame >= 6:
					fake_frame = 0
			true_frame = animations[anim][fake_frame]
			spr_object.set_sprite()
			EXframe_timer += 1
			if EXframe_timer >= 4:
				EXframe_timer = 0
				EXfake_frame += 1
				if EXfake_frame >= 2:
					EXfake_frame = 0
			true_frame = animations[18][EXfake_frame]
		19: # Fireball Idle
			true_frame = animations[anim][0]
		20: # Fireball Move
			true_frame = animations[anim][0]
		21: # Growing
			frame_timer += 1
			if frame_timer >= 4:
				frame_timer = 0
				fake_frame += 1
				if fake_frame >= 11:
					fake_frame = 10
			true_frame = animations[anim][fake_frame]
		22: # Shrinking
			frame_timer += 1
			if frame_timer >= 4:
				frame_timer = 0
				fake_frame += 1
				if fake_frame >= 10:
					fake_frame = 9
			true_frame = animations[anim][fake_frame]
		_:
			true_frame = animations[0][0]
	last_anim = anim
	spr_object.set_sprite()
## END of animate


func editor_sprite() -> void:
	var tileframes: Array
	tileframes.push_back([12,15,false,false])
	tileframes.push_back([12,15,false,false])
	tileframes.push_back([12,15,false,false])
	tileframes.push_back([12,15,false,false])
	tileframes.push_back([10,3,false,false])
	tileframes.push_back([7,3,false,false])
	tileframes.push_back([15,4,false,false])
	tileframes.push_back([15,4,true,false])
	edit_frame.append_array(tileframes)
	tileframes.clear()
## END of editor_sprite
