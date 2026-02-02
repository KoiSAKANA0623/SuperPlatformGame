#@tool
@icon("res://Icons/spr_obj_node.svg")
extends Node2D
class_name SpriteObject

@export var animation: SpriteAnim
var anim: int = 0
var horz_mirror: bool = false
var vert_mirror: bool = false


#func _ready() -> void:
#	pass
## END of _ready


func _process(delta: float) -> void:
	if animation:
		animation.animate(anim)
	if horz_mirror:
		for i in get_children():
			if i.get_index() % 2 == 0:
				i.position.x = 8
			else:
				i.position.x = 0
	else:
		for i in get_children():
			if i.get_index() % 2 == 0:
				i.position.x = 0
			else:
				i.position.x = 8
## END of _process


func set_sprite() -> void:
	for i in get_children():
		var indx = i.get_index()
		var spr_frame = animation.frames
		var frame_add = animation.true_frame * 8
		if spr_frame[indx+frame_add][4] == true:
			var flipX = spr_frame[indx+frame_add][2]
			if horz_mirror:
				flipX = !flipX
			var flipY = spr_frame[indx+frame_add][3]
			if vert_mirror:
				flipY = !flipY
			i.tile_change(
				spr_frame[indx+frame_add][0],spr_frame[indx+frame_add][1],
				flipX,flipY
			)
## END of set_sprite
