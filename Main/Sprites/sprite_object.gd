@tool
@icon("res://Icons/spr_obj_node.svg")
extends Node2D
class_name SpriteObject

@export var animation: SpriteAnim

var frame: int = 8


func _ready() -> void:
	set_sprite()
## END of _ready


func set_sprite() -> void:
	for i in get_children():
		var indx = i.get_index()
		var spr_frame = animation.frames
		var frame_add = frame * 8
		i.tile_change(
			spr_frame[indx+frame_add][0],spr_frame[indx+frame_add][1],
			spr_frame[indx+frame_add][2],spr_frame[indx+frame_add][3]
		)
## END of set_sprite
