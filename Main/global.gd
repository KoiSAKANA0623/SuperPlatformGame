@tool
extends Node

@onready var CHR_SPR : Texture = preload("res://Char/SPR.png")
@onready var CHR_BG : Texture = preload("res://Char/BG.png")
@onready var MainPal : Texture = preload("res://Palette/MainPal.png")
@onready var Pal_Shader : ShaderMaterial = preload("res://Main/PaletteMat.tres")

@onready var Block = preload("res://Main/Level/LvlObj/block.tscn")

var TILPal0 : Texture = preload("res://Palette/SPRPal0.png")
var TILPal1 : Texture = preload("res://Palette/SPRPal0.png")
var TILPal2 : Texture = preload("res://Palette/SPRPal0.png")
var TILPal3 : Texture = preload("res://Palette/SPRPal0.png")

var SPRPal0 : Texture = preload("res://Palette/SPRPal0.png")
var SPRPal1 : Texture = preload("res://Palette/SPRPal3.png")
var SPRPal2 : Texture = preload("res://Palette/SPRPal4.png")
var SPRPal3 : Texture = preload("res://Palette/SPRPal5.png")

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
