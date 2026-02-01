extends "res://Main/Sprites/sprite_anim.gd"

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
# 12 = SM Swim 3
# 13 = SM Swim 4
func set_frames() -> void:
	var tileframes: Array
# Small Mario
	# SM Idle
	tileframes.push_back([12,15,false,false])
	tileframes.push_back([12,15,false,false])
	tileframes.push_back([12,15,false,false])
	tileframes.push_back([12,15,false,false])
	tileframes.push_back([10,3,false,false])
	tileframes.push_back([7,3,false,false])
	tileframes.push_back([15,4,false,false])
	tileframes.push_back([15,4,true,false])
	frames.append_array(tileframes)
	tileframes.clear()
	# SM Walk 0
	tileframes.push_back([12,15,false,false])
	tileframes.push_back([12,15,false,false])
	tileframes.push_back([12,15,false,false])
	tileframes.push_back([12,15,false,false])
	tileframes.push_back([6,3,false,false])
	tileframes.push_back([7,3,false,false])
	tileframes.push_back([8,3,false,false])
	tileframes.push_back([9,3,false,false])
	frames.append_array(tileframes)
	tileframes.clear()
	# SM Walk 1
	tileframes.push_back([12,15,false,false])
	tileframes.push_back([12,15,false,false])
	tileframes.push_back([12,15,false,false])
	tileframes.push_back([12,15,false,false])
	tileframes.push_back([10,3,false,false])
	tileframes.push_back([7,3,false,false])
	tileframes.push_back([11,3,false,false])
	tileframes.push_back([12,3,false,false])
	frames.append_array(tileframes)
	tileframes.clear()
	# SM Walk 2
	tileframes.push_back([12,15,false,false])
	tileframes.push_back([12,15,false,false])
	tileframes.push_back([12,15,false,false])
	tileframes.push_back([12,15,false,false])
	tileframes.push_back([2,3,false,false])
	tileframes.push_back([3,3,false,false])
	tileframes.push_back([4,3,false,false])
	tileframes.push_back([5,3,false,false])
	frames.append_array(tileframes)
	tileframes.clear()
	# SM Skid
	tileframes.push_back([12,15,false,false])
	tileframes.push_back([12,15,false,false])
	tileframes.push_back([12,15,false,false])
	tileframes.push_back([12,15,false,false])
	tileframes.push_back([13,3,false,false])
	tileframes.push_back([14,3,false,false])
	tileframes.push_back([15,3,false,false])
	tileframes.push_back([0,4,false,false])
	frames.append_array(tileframes)
	tileframes.clear()
	# SM Jump
	tileframes.push_back([12,15,false,false])
	tileframes.push_back([12,15,false,false])
	tileframes.push_back([12,15,false,false])
	tileframes.push_back([12,15,false,false])
	tileframes.push_back([2,3,false,false])
	tileframes.push_back([1,4,false,false])
	tileframes.push_back([2,4,false,false])
	tileframes.push_back([3,4,false,false])
	frames.append_array(tileframes)
	tileframes.clear()
	# SM Death
	tileframes.push_back([12,15,false,false])
	tileframes.push_back([12,15,false,false])
	tileframes.push_back([12,15,false,false])
	tileframes.push_back([12,15,false,false])
	tileframes.push_back([14,9,false,false])
	tileframes.push_back([14,9,true,false])
	tileframes.push_back([15,9,false,false])
	tileframes.push_back([15,9,true,false])
	frames.append_array(tileframes)
	tileframes.clear()
	# SM Climb 0
	tileframes.push_back([12,15,false,false])
	tileframes.push_back([12,15,false,false])
	tileframes.push_back([12,15,false,false])
	tileframes.push_back([12,15,false,false])
	tileframes.push_back([2,3,false,false])
	tileframes.push_back([3,3,false,false])
	tileframes.push_back([0,9,false,false])
	tileframes.push_back([1,9,false,false])
	frames.append_array(tileframes)
	tileframes.clear()
	# SM Climb 1
	tileframes.push_back([12,15,false,false])
	tileframes.push_back([12,15,false,false])
	tileframes.push_back([12,15,false,false])
	tileframes.push_back([12,15,false,false])
	tileframes.push_back([10,3,false,false])
	tileframes.push_back([7,3,false,false])
	tileframes.push_back([2,9,false,false])
	tileframes.push_back([3,9,false,false])
	frames.append_array(tileframes)
	tileframes.clear()
	# SM Swim 0

	# SM Swim 1

	# SM Swim 2

	# SM Swim 3

	# SM Swim 4

## END of set_frames
