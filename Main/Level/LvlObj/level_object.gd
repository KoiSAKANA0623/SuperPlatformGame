extends Node2D
class_name Level_Object


# WILL MOVE AFTER I TEST!
func floor_pattern(floor_bit) -> void:
	var inst_block

	for x in 32:
		for y in 13:
			if Global.floor_pattern_arr[floor_bit][y] == 1:
				inst_block = Global.Block.instantiate()
				add_child(inst_block)
				inst_block.position.y = 32.0 + (y*16)
				inst_block.position.x = x*16
## END of floor_pattern
