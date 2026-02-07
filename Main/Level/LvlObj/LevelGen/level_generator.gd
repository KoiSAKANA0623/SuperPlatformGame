extends Level_Object

var refresh_check: int = 0
var hole_flag: bool = false

var level_dict: Dictionary


func _init() -> void:
	lvl_object_type = "LVL_GENERATOR"
## END of _init


func generate(level_type) -> void:
	background_pattern()
	floor_pattern(level_type)
## END of generate


func floor_pattern(level_type) -> void:
	var blockT: Block_Tilemap = block_tiles.new()
	var inst_block

	var block2place
	match level_type:
		0:
			block2place = blockT.tile_map["UNDERWATER"]
		1:
			block2place = blockT.tile_map["GROUND"]
		2:
			block2place = blockT.tile_map["BRICK"]
		3:
			block2place = blockT.tile_map["CASTLE"]

	var y_pos: Array
	y_pos.resize(5)
	y_pos.fill(0)
	var column: Array
	column.resize(5)
	column.fill(0)
	var row: int
	## PASS 1
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
			if level_type == 2:
				if y > 10:
					block2place = blockT.tile_map["GROUND"]
				else:
					block2place = blockT.tile_map["BRICK"]
			if y > 7 && hole_flag == true:
				continue
			if Global.platform_bit == 3:
				block2place = blockT.tile_map["CLOUD"]
				if y > 11:
					continue
			if Global.floor_pattern_arr[Global.floor_bit][y] == 1:
				inst_block = Global.Block.instantiate()
				add_child(inst_block)
				inst_block.position.y = 32.0 + (y*16)
				inst_block.position.x = (refresh_check) * 16
				setup_block(inst_block, block2place)
				level_dict[inst_block] = inst_block.position
	## PASS 2
		var num_of_y_obj: int = 0
		for i in get_parent().get_children():
			if int(i.global_position.x/16) > refresh_check:
				continue
			elif i is Level_Object:
				if i.lvl_object_type == "HARDBLOCK" or i.lvl_object_type == "BRICK":
					num_of_y_obj += 1
					y_pos.set(num_of_y_obj-1,i.global_position.y)
					block2place = blockT.tile_map[i.lvl_object_type]
					if !i.col_or_row:
						column.set(num_of_y_obj-1,i.range)
						i.queue_free()
					else:
						row = i.range
						column.set(num_of_y_obj-1,1)
					if row + int(i.global_position.x/16) <= refresh_check + 1:
						row = 0
						i.queue_free()
		for n in num_of_y_obj:
			for y in 13:
				if column[num_of_y_obj-1]:
					check_delete_at(refresh_check*16,(y*16) + y_pos[num_of_y_obj-1])
					inst_block = Global.Block.instantiate()
					add_child(inst_block)
					inst_block.position.y = (y*16) + y_pos[num_of_y_obj-1]
					inst_block.position.x = (refresh_check) * 16
				#	inst_block.visible = false
					setup_block(inst_block, block2place)
					if column[num_of_y_obj-1]:
						column[num_of_y_obj-1] -= 1
					else:
						column[num_of_y_obj-1] = 0
			num_of_y_obj -= 1

		refresh_check += 1
## END of floor_pattern


func setup_block(block, block2place) -> void:
	block.palInt = block2place[8]
	block.build_block(block2place)
## END of setup_block


func check_delete_at(x,y) -> void:
	var block_ = level_dict.find_key(Vector2(x,y))
	if block_:
		block_.queue_free()
		level_dict.erase(block_)
## END of delete_at


func background_pattern() -> void:
#	print("Here is where pain begins")
	pass
## END of b
