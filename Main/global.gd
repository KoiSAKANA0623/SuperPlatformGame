@tool
extends Node

@onready var CHR_SPR : Texture = preload("res://Char/SPR.png")
@onready var CHR_BG : Texture = preload("res://Char/BG.png")
@onready var MainPal : Texture = preload("res://Palette/MainPal.png")
@onready var Pal_Shader : ShaderMaterial = preload("res://Main/PaletteMat.tres")

@onready var Block = preload("res://Main/Level/LvlObj/block.tscn")

var TILPal0 : Texture = preload("res://Palette/TILPal0.png")
var TILPal1 : Texture = preload("res://Palette/TILPal1.png")
var TILPal2 : Texture = preload("res://Palette/TILPal2.png")
var TILPal3 : Texture = preload("res://Palette/TILPal3.png")

var SPRPal0 : Texture = preload("res://Palette/SPRPal0.png")
var SPRPal1 : Texture = preload("res://Palette/SPRPal3.png")
var SPRPal2 : Texture = preload("res://Palette/SPRPal4.png")
var SPRPal3 : Texture = preload("res://Palette/SPRPal5.png")

var camera_pos : int = 0.0

var refresh_line: int = 12

var floor_bit: int = 0
var floor_pattern_arr: Array = [
	[0,0,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0,0,1,1],
	[1,0,0,0,0,0,0,0,0,0,0,1,1],
	[1,1,1,0,0,0,0,0,0,0,0,1,1],
	[1,1,1,1,0,0,0,0,0,0,0,1,1],
	[1,1,1,1,1,1,1,1,0,0,0,1,1],
	[1,0,0,0,0,0,0,0,1,1,1,1,1],
	[1,1,1,0,0,0,0,0,1,1,1,1,1],
	[1,1,1,1,0,0,0,0,1,1,1,1,1],
	[1,0,0,0,0,0,0,1,1,1,1,1,1],
	[1,0,0,0,0,0,0,0,0,0,0,0,0],
	[1,1,1,1,0,0,0,1,1,1,1,1,1],
	[1,0,0,0,1,1,1,1,1,1,1,1,1],
	[1,0,0,1,1,1,1,1,0,0,0,1,1],
	[1,0,0,0,1,1,1,1,0,0,0,1,1],
	[1,1,1,1,1,1,1,1,1,1,1,1,1]
]


#func _process(delta: float) -> void:
#	print(refresh_line)
## END of _process
