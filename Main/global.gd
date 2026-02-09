@tool
extends Node

var FPS: float = 60.0
var frame_times: Array = []

var main_
var main_level_n
var main_sprit_n
var main_spritbh_n

var interval_timer: int = 20

@onready var CHR_SPR : Texture = preload("res://Char/SPR.png")
@onready var CHR_BG : Texture = preload("res://Char/BG.png")
@onready var MainPal : Texture = preload("res://Palette/MainPal.png")
const Pal_Shader : ShaderMaterial = preload("res://Main/PaletteMat.tres")
var coin_color : String = "EA9E22"

@onready var Block = preload("res://Main/Level/LvlObj/block.tscn")

var TILPal0 : Texture = preload("res://Palette/TILPal0.png")
var TILPal1 : Texture = preload("res://Palette/TILPal1.png")
var TILPal2 : Texture = preload("res://Palette/TILPal2.png")
var TILPal3 : Texture = preload("res://Palette/TILPal3_0.png")

var SPRPal0 : Texture = preload("res://Palette/SPRPal0.png")
var SPRPal1 : Texture = preload("res://Palette/SPRPal3.png")
var SPRPal2 : Texture = preload("res://Palette/SPRPal4.png")
var SPRPal3 : Texture = preload("res://Palette/SPRPal5.png")

var camera_pos : float = 0.0
var refresh_line: int = 12
var mario_pos : Vector2 = Vector2(0,0)
var mario_big : bool = false
var lock_cam : bool = false

var powerup_l

var floor_bit: int = 0
var floor_pattern_arr: Array = [
	[0,0,0,0,0,0,0,0,0,0,0,0,0], # 0
	[0,0,0,0,0,0,0,0,0,0,0,1,1], # 1
	[1,0,0,0,0,0,0,0,0,0,0,1,1], # 2
	[1,1,1,0,0,0,0,0,0,0,0,1,1], # 3
	[1,1,1,1,0,0,0,0,0,0,0,1,1], # 4
	[1,1,1,1,1,1,1,1,0,0,0,1,1], # 5
	[1,0,0,0,0,0,0,0,1,1,1,1,1], # 6
	[1,1,1,0,0,0,0,0,1,1,1,1,1], # 7
	[1,1,1,1,0,0,0,0,1,1,1,1,1], # 8
	[1,0,0,0,0,0,0,1,1,1,1,1,1], # 9
	[1,0,0,0,0,0,0,0,0,0,0,0,0], # 10
	[1,1,1,1,0,0,0,1,1,1,1,1,1], # 11
	[1,0,0,0,1,1,1,1,1,1,1,1,1], # 12
	[1,0,0,1,1,1,1,1,0,0,0,1,1], # 13
	[1,0,0,0,1,1,1,1,0,0,0,1,1], # 14
	[1,1,1,1,1,1,1,1,1,1,1,1,1]  # 15
]
var platform_bit: int = 0


#func _ready() -> void:
#	RenderingServer
## END of _ready
