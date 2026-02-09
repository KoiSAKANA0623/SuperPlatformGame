@tool
@icon("res://Icons/spr_tile_node.png")
extends Sprite2D
class_name SpriteTile

@export_range(0,3) var palInt: int = 0
var palette: Texture = Global.SPRPal0


func _ready() -> void:
	texture = Global.CHR_SPR
	region_enabled = true
	region_rect = Rect2(0,0,8,8)
	centered = false
	texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	material = Global.Pal_Shader.duplicate()
	pal_line_change(palInt)
## END of _ready


func _process(_delta: float) -> void:
	if global_position.x < Global.camera_pos:
		visible = false
	else:
		visible = true
## END of _process


func tile_change(x, y, flX, flY) -> void:
	region_rect.position.x = x * 8
	region_rect.position.y = y * 8
	flip_h = flX
	flip_v = flY
## END of tile_change


func pal_line_change(palette_id) -> void:
	match palette_id:
		0:
			palette = Global.SPRPal0
		1:
			palette = Global.SPRPal1
		2:
			palette = Global.SPRPal2
		3:
			palette = Global.SPRPal3
		_:
			palette = Global.SPRPal0
	material.set("shader_parameter/oldP", Global.MainPal)
	material.set("shader_parameter/newP", palette)
## END of pal_line_change
