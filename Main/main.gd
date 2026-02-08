@tool
extends Node2D

@onready var bg = $BG/BGColor
@onready var level_node = $Level
@onready var sprite_node = $Sprites
@onready var lvl_gen = preload("res://Main/Level/LvlObj/LevelGen/level_generator.tscn")
var edit_tiles: TileMapLayer
var inst_lvl_gen
@onready var mario = preload("res://Main/Objects/Mario/mario.tscn")
## 00 Timer - 000 Mario Start - 000 BG Details - 00 Tiles - 00 Scenary - 0000 Initial Floor Pattern
@export var tileDATA: int = 20513 #5021, 0101000000100001  1-2 0100100011001111
## 0 = Water, 1 = Ground, 2 = Underground, 3 = Castle
@export_range(0,3,1) var level_type: int = 1

var bg_palette: String = "9290FF"
var mario_start: int = 0

var init_tileplat: int = 0
var init_floor_bit: int = 0

var hole_r: int = 0
var bit_mask: int = 1 << 15


func _ready() -> void:
	Global.main_level_n = level_node
	Global.main_sprit_n = sprite_node
	edit_tiles = $EditorTiles
	load_level()
	if Engine.is_editor_hint():
		return
	edit_tiles.queue_free()
	edit_tiles = null
	inst_lvl_gen = lvl_gen.instantiate()
	level_node.add_child(inst_lvl_gen)
	load_sprites()
## END of _ready


func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		editor_tilemap()
		return
	inst_lvl_gen.generate(level_type)

	var now = Time.get_ticks_msec()
	while Global.frame_times.size() > 0 && Global.frame_times[0] <= now - 1000:
		Global.frame_times.pop_front()
	Global.frame_times.append(now)
	Global.FPS = Global.frame_times.size()
	$BG/Label.text = "fps: %d" % Global.FPS
## END of _process


func load_level() -> void:
	print(String.num_int64(tileDATA,16, true)+", "+String.num_int64(tileDATA,2))
	## reads from right to left

	match level_type:
		0:
			bg_palette = "9290FF"
			Global.SPRPal1 = load("res://Palette/SPRPal9.png")
			Global.SPRPal2 = load("res://Palette/SPRPal4.png")
			Global.SPRPal3 = load("res://Palette/SPRPalA.png")

			Global.TILPal0 = load("res://Palette/TILPalB.png")
			Global.TILPal1 = load("res://Palette/TILPalC.png")
			Global.TILPal2 = load("res://Palette/TILPalD.png")
			Global.TILPal3 = load("res://Palette/TILPalE.png")
		1:
			bg_palette = "9290FF"
			Global.SPRPal1 = load("res://Palette/SPRPal3.png")
			Global.SPRPal2 = load("res://Palette/SPRPal4.png")
			Global.SPRPal3 = load("res://Palette/SPRPal5.png")

			Global.TILPal0 = load("res://Palette/TILPal0.png")
			Global.TILPal1 = load("res://Palette/TILPal1.png")
			Global.TILPal2 = load("res://Palette/TILPal2.png")
			Global.TILPal3 = load("res://Palette/TILPal3.png")
		2:
			bg_palette = "000000"
			Global.SPRPal1 = load("res://Palette/SPRPal6.png")
			Global.SPRPal2 = load("res://Palette/SPRPal4.png")
			Global.SPRPal3 = load("res://Palette/SPRPal7.png")

			Global.TILPal0 = load("res://Palette/TILPal4.png")
			Global.TILPal1 = load("res://Palette/TILPal5.png")
			Global.TILPal2 = load("res://Palette/TILPal6.png")
			Global.TILPal3 = load("res://Palette/TILPal7.png")
		3:
			bg_palette = "000000"
			Global.SPRPal1 = load("res://Palette/SPRPal6.png")
			Global.SPRPal2 = load("res://Palette/SPRPal4.png")
			Global.SPRPal3 = load("res://Palette/SPRPal8.png")

			Global.TILPal0 = load("res://Palette/TILPal8.png")
			Global.TILPal1 = load("res://Palette/TILPal8.png")
			Global.TILPal2 = load("res://Palette/TILPal9.png")
			Global.TILPal3 = load("res://Palette/TILPalA.png")
	bg.color = bg_palette
	bg.size = Vector2(256.0,240.0)

	# checks timer
	var timer_bit: int = 0
	if tileDATA & bit_mask:
		timer_bit += 2
	bit_mask = 1 << 14
	if tileDATA & bit_mask:
		timer_bit += 1
	match timer_bit:
		0: # 00
			print("NO CHANGE")
		1: # 01
			print("TIMER 400")
		2: # 10
			print("TIMER 300")
		3: # 11
			print("TIMER 200")

	# checks Mario start pos
	bit_mask = 1 << 13
	if tileDATA & bit_mask:
		mario_start += 4
	bit_mask = 1 << 12
	if tileDATA & bit_mask:
		mario_start += 2
	bit_mask = 1 << 11
	if tileDATA & bit_mask:
		mario_start += 1

	# checks background details/color
	var bg_bit: int = 0
	bit_mask = 1 << 10
	if tileDATA & bit_mask:
		bg_bit += 4
	bit_mask = 1 << 9
	if tileDATA & bit_mask:
		bg_bit += 2
	bit_mask = 1 << 8
	if tileDATA & bit_mask:
		bg_bit += 1
	match bg_bit:
		0: # 000
			print("BG OVERWORLD")
		1: # 001
			print("BG UNDERWATER")
		2: # 010
			print("BG CASTLE")
		3: # 011
			print("BG OVERWORLD WATER")
		4: # 100
			print("BG NIGHT")
		5: # 101
			print("BG SNOW")
		6: # 110
			print("BG SNOW NIGHT")
		7: # 111
			print("BG NIGHT CASLTE")

	# checks tiles && special platform
	set_init_tileplat()

	# checks scenary
	var scenary_bit: int = 0
	bit_mask = 1 << 5
	if tileDATA & bit_mask:
		scenary_bit += 2
	bit_mask = 1 << 4
	if tileDATA & bit_mask:
		scenary_bit += 1
	match scenary_bit:
		0: # 00
			print("NOTHING")
		1: # 01
			print("CLOUDS")
		2: # 10
			print("CLOUDS BUSHES MOUNTAIN")
		3: # 11
			print("CLOUDS TREES FENCE")

	# checks init floor pattern
	set_init_floor()
	return
## END of load_level


func set_init_tileplat() -> void:
	init_tileplat = 0
	bit_mask = 1 << 7
	if tileDATA & bit_mask:
		init_tileplat += 2
	bit_mask = 1 << 6
	if tileDATA & bit_mask:
		init_tileplat += 1
	Global.platform_bit = init_tileplat
## END of set_init_tileplat


func set_init_floor() -> void:
	init_floor_bit = 0
	bit_mask = 1 << 3
	if tileDATA & bit_mask:
		init_floor_bit += 8
	bit_mask = 1 << 2
	if tileDATA & bit_mask:
		init_floor_bit += 4
	bit_mask = 1 << 1
	if tileDATA & bit_mask:
		init_floor_bit += 2
	bit_mask = 1 << 0
	if tileDATA & bit_mask:
		init_floor_bit += 1
	Global.floor_bit = init_floor_bit
## END of set_init_floor


func load_sprites() -> void:
## Mario
	var inst_mario = mario.instantiate()
	sprite_node.add_child(inst_mario)

	inst_mario.global_position.x = 40.0
	match mario_start:
		0: # WATER, Y=0
			inst_mario.global_position.y = 0.0
		1: # UNDERGROUND, Y=32
			inst_mario.global_position.y = 32.0
		2: # OVERWORLD, Y=176
			inst_mario.global_position.y = 176.0
		3: # CASTLE, Y=80
			inst_mario.global_position.y = 80.0
		4: # UNUSED, Y=0
			inst_mario.global_position.y = 0.0
		5: # UNUSED, Y=0
			inst_mario.global_position.y = 0.0
		6: # UNUSED, Y=176
			inst_mario.global_position.y = 176.0
		7: # AUTOWALK, Y=176
			inst_mario.global_position.y = 176.0
			inst_mario.control_lock = true
			inst_mario.cutscene_type = 1

	if level_type == 0:
		inst_mario.underwater = true
## END of load_sprites


func editor_tilemap() -> void:
	var edit_refresh: int = 0
	var level_end: int = 16
	var pos: Vector2i
	var tile_pos: Vector2i = Vector2i(0,0)

	set_init_tileplat()
	set_init_floor()

	match level_type:
		0:
			tile_pos = Vector2i(4,1)
			bg_palette = "9290FF"
		1:
			bg_palette = "9290FF"
		2:
			bg_palette = "000000"
		3:
			tile_pos = Vector2i(11,1)
			bg_palette = "000000"
	bg.color = bg_palette

	for i in level_node.get_children():
		if int(i.global_position.x/16) > level_end:
			level_end = int(i.global_position.x/16)
		i.edit_enable = true

	bg.size = Vector2((level_end+4)*16,240.0)

	# set tiles on tilemap
	edit_tiles.clear()
	for x in (level_end+4) - edit_refresh:
		for i in level_node.get_children():
			if !i.edit_enable:
				continue
			if int(i.global_position.x/16) > edit_refresh:
				continue
			if i is Level_Object:
				if i.lvl_object_type == "FLOOR_CHANGE":
					init_floor_bit = i.new_floor_bit
				elif i.lvl_object_type == "HOLE":
					hole_r = i.hole_range + int(i.global_position.x/16)
			i.edit_enable = false
		if edit_refresh >= hole_r:
			hole_r = 0
		for y in 13:
			if level_type == 2:
				if y > 10:
					tile_pos = Vector2i(0,0)
				else:
					tile_pos = Vector2i(1,2)
			if y > 7 && hole_r:
				continue
			if init_tileplat == 3:
				tile_pos = Vector2i(10,0)
				if y > 11:
					continue
			if Global.floor_pattern_arr[init_floor_bit][y] == 1:
				var new_tilepos = tile_pos
				pos.x = x
				pos.y = y+2
				new_tilepos.y = tile_pos.y+(level_type * 5)
				edit_tiles.set_cell(pos, 0, new_tilepos)
		edit_refresh += 1
#	print(hole_f)
	return
## END of load_sprites
