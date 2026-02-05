extends Node2D
class_name Level_Object

const block_tiles = preload("res://Main/Level/LvlObj/block_tilemap.gd")

@export var lvl_object_type: String = "FLOOR_PATTERN"
var refresh_check: int = 0


# WILL MOVE AFTER I TEST!
func floor_pattern(floor_bit) -> void:
	var blockT: Block_Tilemap = block_tiles.new()
	var inst_block

	# check for other floor pattern objects
	for x in Global.refresh_line - refresh_check:
		for y in 13:
			if Global.floor_pattern_arr[floor_bit][y] == 1:
				inst_block = Global.Block.instantiate()
				inst_block.palInt = 1
				add_child(inst_block)
				inst_block.position.y = 32.0 + (y*16)
				inst_block.position.x = (refresh_check) * 16
				inst_block.build_block(blockT.GROUND_Tile)
		refresh_check += 1
## END of floor_pattern
