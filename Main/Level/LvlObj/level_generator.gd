extends Level_Object

var refresh_check: int = 0

var hole_flag: bool = false


func _init() -> void:
	lvl_object_type = "FLOOR_PATTERN"
## END of _init


func generate() -> void:
	background_pattern()
	floor_pattern()
## END of generate


func floor_pattern() -> void:
	var blockT: Block_Tilemap = block_tiles.new()
	var inst_block

	# check for other floor pattern objects
	for x in Global.refresh_line - refresh_check:
		for i in get_parent().get_children():
			if int(i.global_position.x/16) > refresh_check:
				continue
			elif i is Level_Object:
				if i.lvl_object_type == "FLOOR_CHANGE":
					Global.floor_bit = i.new_floor_bit
					i.queue_free()
				if i.lvl_object_type == "HOLE":
					if i.hole_range == 0:
						i.queue_free()
						hole_flag = false
						continue
					else:
						i.hole_range -= 1
						hole_flag = true
		for y in 13:
			if y > 7 && hole_flag == true:
				refresh_check += 1
				return
			if Global.floor_pattern_arr[Global.floor_bit][y] == 1:
				inst_block = Global.Block.instantiate()
				inst_block.palInt = 1
				add_child(inst_block)
				inst_block.position.y = 32.0 + (y*16)
				inst_block.position.x = (refresh_check) * 16
				inst_block.build_block(blockT.GROUND_Tile)
		refresh_check += 1
## END of floor_pattern


func background_pattern() -> void:
	print("Here is where pain begins")
	pass
## END of b
