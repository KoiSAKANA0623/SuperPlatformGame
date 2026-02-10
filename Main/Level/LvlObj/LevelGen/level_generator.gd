extends Level_Object

var refresh_check: int = 0
var hole_flag: bool = false

var level_dict: Dictionary
var level_impor: Dictionary

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

	var x_pos: Array
	x_pos.resize(5)
	x_pos.fill(0)
	var y_pos: Array
	y_pos.resize(5)
	y_pos.fill(0)
	var column: Array
	column.resize(5)
	column.fill(0)
	var row: Array
	row.resize(5)
	row.fill(0)
	var block_tile: Array
	block_tile.resize(5)
	block_tile.fill(0)
	var impor: Array
	impor.resize(5)
	impor.fill(0)
	var item: Array
	item.resize(5)
	item.fill(-1)
	for x in Global.refresh_line - refresh_check:
	## PASS 1
		for i in get_parent().get_children():
			if int(i.global_position.x/16) > refresh_check:
				continue
			elif i is Level_Object:
				if i.lvl_object_type == "FLOOR_CHANGE":
					Global.floor_bit = i.new_floor_bit
					i.queue_free()
				elif i.lvl_object_type == "HOLE":
					if i.hole_range == 0:
						i.queue_free()
						hole_flag = false
						continue
					else:
						i.hole_range -= 1
						hole_flag = true
				elif i.lvl_object_type == "CAMERA_LOCK":
					if i.warp_scroll:
						Global.lock_cam = true
						return
					elif Global.mario_pos.y < 32:
						Global.lock_cam = false
					else:
						Global.lock_cam = true
					i.queue_free()
		for y in 13:
			if Global.floor_pattern_arr[Global.floor_bit][y] == 1:
				match level_type:
					0:
						block2place = blockT.tile_map["UNDERWATER"]
					1:
						block2place = blockT.tile_map["GROUND"]
					2:
						block2place = blockT.tile_map["BRICK"]
					3:
						block2place = blockT.tile_map["CASTLE"]
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
				inst_block = Global.Block.instantiate()
				add_child(inst_block)
				inst_block.position.y = 32.0 + (y*16)
				inst_block.position.x = (refresh_check) * 16
				setup_block(inst_block, block2place, blockT)
				level_dict[inst_block] = inst_block.position
				level_impor[inst_block] = 0
	## PASS 2
		for y in 13:
			if y > 7 && hole_flag == true:
				continue
			match Global.bg_bit:
				1:
					if y >= 0:
						block2place = blockT.tile_map["WATER_SURFACE"]
						if y >= 1:
							block2place = blockT.tile_map["WATER"]
						if check_delete_at(refresh_check*16,32.0 + (y*16), -1):
							continue
						inst_block = Global.Block.instantiate()
						add_child(inst_block)
						inst_block.position.y = 32.0 + (y*16)
						inst_block.position.x = (refresh_check) * 16
						setup_block(inst_block, block2place, blockT)
						level_dict[inst_block] = inst_block.position
						level_impor[inst_block] = -1
				3:
					if y >= 11:
						block2place = blockT.tile_map["WATER_SURFACE"]
						if y >= 12:
							block2place = blockT.tile_map["WATER"]
						if check_delete_at(refresh_check*16,32.0 + (y*16), -1):
							continue
						inst_block = Global.Block.instantiate()
						add_child(inst_block)
						inst_block.position.y = 32.0 + (y*16)
						inst_block.position.x = (refresh_check) * 16
						setup_block(inst_block, block2place, blockT)
						level_dict[inst_block] = inst_block.position
						level_impor[inst_block] = -1
	## PASS 3
		var num_of_y_obj: int = 0
		for i in get_parent().get_children():
			if int(i.global_position.x/16) > refresh_check:
				continue
			elif i is Level_Object:
				if i.lvl_object_type == "HARDBLOCK" or i.lvl_object_type == "BRICK":
					num_of_y_obj += 1
					impor[num_of_y_obj-1] = 1
					y_pos.set(num_of_y_obj-1,i.global_position.y)
					block_tile[num_of_y_obj-1] = blockT.tile_map[i.lvl_object_type]
					if !i.col_or_row:
						column.set(num_of_y_obj-1,i.range)
						row.set(num_of_y_obj-1,1)
						i.queue_free()
					else:
						row.set(num_of_y_obj-1,i.range)
						column.set(num_of_y_obj-1,1)
					if row[num_of_y_obj-1] + int(i.global_position.x/16) <= refresh_check:
						row[num_of_y_obj-1] = 0
						i.queue_free()
				elif i.lvl_object_type == "STAIRCASE":
					num_of_y_obj += 1
					impor[num_of_y_obj-1] = 1
					row.set(num_of_y_obj-1,i.range)
					block_tile[num_of_y_obj-1] = blockT.tile_map["HARDBLOCK"]
					if row[num_of_y_obj-1] + int(i.global_position.x/16) <= refresh_check:
						row[num_of_y_obj-1] = 0
						i.queue_free()
					else:
						var q = clamp(refresh_check - int(i.global_position.x/16),0,7)
						column.set(num_of_y_obj-1,1+q)
						y_pos.set(num_of_y_obj-1,i.global_position.y-(q-i.range+1)*16)
				elif i.lvl_object_type == "PIPE":
					impor[num_of_y_obj-1] = 0
					num_of_y_obj += 1
					x_pos.set(num_of_y_obj-1,i.global_position.x)
					y_pos.set(num_of_y_obj-1,i.global_position.y)
					row.set(num_of_y_obj-1,2)
					column.set(num_of_y_obj-1,i.height)
					block_tile[num_of_y_obj-1] = blockT.tile_map["PIPE_00"]
					if row[num_of_y_obj-1] + int(i.global_position.x/16) <= refresh_check:
						row[num_of_y_obj-1] = 0
						i.queue_free()
				elif i.lvl_object_type == "QUESTION_BLOCK":
					num_of_y_obj += 1
					impor[num_of_y_obj-1] = 2
					item[num_of_y_obj-1] = 1
					y_pos.set(num_of_y_obj-1,i.global_position.y)
					row.set(num_of_y_obj-1,i.length)
					column.set(num_of_y_obj-1,1)
					block_tile[num_of_y_obj-1] = blockT.tile_map[i.lvl_object_type]
					if row[num_of_y_obj-1] + int(i.global_position.x/16) <= refresh_check:
						row[num_of_y_obj-1] = 0
						i.queue_free()
				elif i.lvl_object_type == "QUESTION_BLOCK_ITEM":
					num_of_y_obj += 1
					impor[num_of_y_obj-1] = 3
					item[num_of_y_obj-1] = i.item
					y_pos.set(num_of_y_obj-1,i.global_position.y)
					column.set(num_of_y_obj-1,1)
					row.set(num_of_y_obj-1,1)
					block_tile[num_of_y_obj-1] = blockT.tile_map["QUESTION_BLOCK"]
					if row[num_of_y_obj-1] + int(i.global_position.x/16) <= refresh_check:
						row[num_of_y_obj-1] = 0
						i.queue_free()
				elif i.lvl_object_type == "BRICK_ITEM":
					num_of_y_obj += 1
					impor[num_of_y_obj-1] = 3
					item[num_of_y_obj-1] = i.item
					y_pos.set(num_of_y_obj-1,i.global_position.y)
					column.set(num_of_y_obj-1,1)
					row.set(num_of_y_obj-1,1)
					block_tile[num_of_y_obj-1] = blockT.tile_map["BRICK"]
					if row[num_of_y_obj-1] + int(i.global_position.x/16) <= refresh_check:
						row[num_of_y_obj-1] = 0
						i.queue_free()
				elif i.lvl_object_type == "COIN":
					num_of_y_obj += 1
					impor[num_of_y_obj-1] = 2
					item[num_of_y_obj-1] = 1
					y_pos.set(num_of_y_obj-1,i.global_position.y)
					row.set(num_of_y_obj-1,i.length)
					column.set(num_of_y_obj-1,1)
					block_tile[num_of_y_obj-1] = blockT.tile_map[i.lvl_object_type]
					if row[num_of_y_obj-1] + int(i.global_position.x/16) <= refresh_check:
						row[num_of_y_obj-1] = 0
						i.queue_free()
		for n in num_of_y_obj:
			for y in 13:
				if column[num_of_y_obj-1] && row[num_of_y_obj-1]:
					if check_delete_at(refresh_check*16,(y*16) + y_pos[num_of_y_obj-1], impor[num_of_y_obj-1]):
						if column[num_of_y_obj-1]:
							column[num_of_y_obj-1] -= 1
						else:
							column[num_of_y_obj-1] = 0
						continue
					inst_block = Global.Block.instantiate()
					add_child(inst_block)
					inst_block.position.y = (y*16) + y_pos[num_of_y_obj-1]
					inst_block.position.x = (refresh_check) * 16
					inst_block.item = item[num_of_y_obj-1]
				#	inst_block.visible = false
					block2place = block_tile[num_of_y_obj-1]
					if block2place == blockT.tile_map["PIPE_00"]:
						var pipe_bit1 = clamp(refresh_check - int(x_pos[num_of_y_obj-1]/16),0,1)
						var pipe_bit2 = clamp(y,0,1)
						block2place = blockT.tile_map["PIPE_"+str(pipe_bit2)+str(pipe_bit1)]
					if level_type == 0:
						if block2place == blockT.tile_map["BRICK"]:
							block2place = blockT.tile_map["CORAL"]
						elif block2place == blockT.tile_map["HARDBLOCK"]:
							block2place = blockT.tile_map["UNDERWATER"]
						elif block2place == blockT.tile_map["COIN"]:
							block2place = blockT.tile_map["COIN_UW"]
					elif level_type == 3:
						if block2place == blockT.tile_map["HARDBLOCK"]:
							block2place = blockT.tile_map["CASTLE"]
					if level_type < 2:
						if block2place == blockT.tile_map["BRICK"]:
							block2place = blockT.tile_map["BRICK_HI"]
					setup_block(inst_block, block2place, blockT)
					level_dict[inst_block] = inst_block.position
					level_impor[inst_block] = impor[num_of_y_obj-1]
					if column[num_of_y_obj-1]:
						column[num_of_y_obj-1] -= 1
					else:
						column[num_of_y_obj-1] = 0
			num_of_y_obj -= 1
		refresh_check += 1
	return
## END of floor_pattern


func place_newblock(x,y, block_) -> void:
	var blockT: Block_Tilemap = block_tiles.new()
	var inst_block
	var block2place =  blockT.tile_map[block_]
	inst_block = Global.Block.instantiate()
	add_child(inst_block)
	inst_block.position.y = y
	inst_block.position.x = x
	setup_block(inst_block, block2place, blockT)
	level_dict[inst_block] = inst_block.position
	level_impor[inst_block] = 3


func setup_block(block, block2place, blockT) -> void:
	block.palInt = block2place[8]
	block.build_block(block2place, blockT.tile_map.find_key(block2place))
## END of setup_block


func check_delete_at(x,y, importance) -> bool:
	var block_ = level_dict.find_key(Vector2(x,y))
	if block_:
		var block_imp = level_impor.get(block_)
		if block_imp > importance:
			return true
		block_.queue_free()
		level_dict.erase(block_)
	return false
## END of delete_at


func background_pattern() -> void:
#	print("Here is where pain begins")
	pass
## END of b
