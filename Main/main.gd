extends Node2D

@onready var bg = $BG/BGColor
@onready var level_node = $Level
@onready var sprite_node = $Sprites
## SWITCH OUT WITH FLOOR PATTERN OBJ WHEN FINISHED
@onready var lvl_object = preload("res://Main/Level/LvlObj/level_object.tscn")
var inst_lvlob

@export var tileDATA: int = 20513 #5021, 0101000000100001
@export var bg_palette: String = "9290FF"


func _ready() -> void:
	load_level()
## END of _ready


func _process(delta: float) -> void:
	inst_lvlob.floor_pattern(Global.floor_bit)
## END of _process


func load_level() -> void:
	print(String.num_int64(tileDATA,16, true)+", "+String.num_int64(tileDATA,2))
	## reads from right to left
	var bit_mask: int = 1 << 15

	# checks timer
	var timer_bit: int = 0
	if tileDATA & bit_mask:
		timer_bit = 2
	bit_mask = 1 << 14
	if tileDATA & bit_mask:
		timer_bit = 1
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
	var mario_bit: int = 0
	bit_mask = 1 << 13
	if tileDATA & bit_mask:
		mario_bit = 4
	bit_mask = 1 << 12
	if tileDATA & bit_mask:
		mario_bit = 2
	bit_mask = 1 << 11
	if tileDATA & bit_mask:
		mario_bit = 1
	match mario_bit:
		0: # 000
			print("WATER, Y=0")
		1: # 001
			print("UNDERGROUND, Y=32")
		2: # 010
			print("OVERWORLD, Y=176")
		3: # 011
			print("CASTLE, Y=80")
		4: # 100
			print("UNUSED, Y=0")
		5: # 101
			print("UNUSED, Y=0")
		6: # 110
			print("UNUSED, Y=176")
		7: # 111
			print("AUTOWALK, Y=176")

	# checks background details/color
	var bg_bit: int = 0
	bit_mask = 1 << 10
	if tileDATA & bit_mask:
		bg_bit = 4
	bit_mask = 1 << 9
	if tileDATA & bit_mask:
		bg_bit = 2
	bit_mask = 1 << 8
	if tileDATA & bit_mask:
		bg_bit = 1
	match bg_bit:
		0: # 000
			print("BG OVERWORLD")
			bg.color = Color(bg_palette)
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
	var tile_bit: int = 0
	bit_mask = 1 << 7
	if tileDATA & bit_mask:
		tile_bit = 2
	bit_mask = 1 << 6
	if tileDATA & bit_mask:
		tile_bit = 1
	match tile_bit:
		0: # 00
			print("DEFAULT, GREEN PIPE, TREE PLATFORM")
		1: # 01
			print("DEFAULT, ORANGE PIPE, MUSHROOM PLATFORM")
		2: # 10
			print("DEFAULT, GREEN PIPE, BULLET BILL")
		3: # 11
			print("CLOUD, GREEN PIPE, TREE PLATFORM")

	# checks scenary
	var scenary_bit: int = 0
	bit_mask = 1 << 5
	if tileDATA & bit_mask:
		scenary_bit = 2
	bit_mask = 1 << 4
	if tileDATA & bit_mask:
		scenary_bit = 1
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
	bit_mask = 1 << 3
	if tileDATA & bit_mask:
		Global.floor_bit = 8
	bit_mask = 1 << 2
	if tileDATA & bit_mask:
		Global.floor_bit = 4
	bit_mask = 1 << 1
	if tileDATA & bit_mask:
		Global.floor_bit = 2
	bit_mask = 1 << 0
	if tileDATA & bit_mask:
		Global.floor_bit = 1
	inst_lvlob = lvl_object.instantiate()
	level_node.add_child(inst_lvlob)
	return
## END of load_level
