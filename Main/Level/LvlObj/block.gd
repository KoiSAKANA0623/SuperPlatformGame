extends StaticBody2D
class_name Blocks

@onready var Visual_Node = $Visual

var palInt: int = 0
var palette: Texture = Global.TILPal0


func _ready() -> void:
	for i in Visual_Node.get_children():
		i.material = Global.Pal_Shader.duplicate()
		i.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
		i.texture = Global.CHR_BG
		i.region_enabled = true
		i.region_rect = Rect2(0,0,8,8)
		i.centered = false
## END of _ready


func _process(delta: float) -> void:
	if global_position.x < Global.camera_pos - 24:
		queue_free()
		pass
## END of _process


func build_block(block_tile) -> void:
	for i in Visual_Node.get_children():
		var indx = i.get_index()
		pal_line_change(i)
		i.region_rect.position.x = block_tile[0+(indx*2)] * 8
		i.region_rect.position.y = block_tile[1+(indx*2)] * 8
## END of build_block


func pal_line_change(i) -> void:
	match palInt:
		0:
			palette = Global.TILPal0
		1:
			palette = Global.TILPal1
		2:
			palette = Global.TILPal2
		3:
			palette = Global.TILPal3
		_:
			palette = Global.TILPal0
	i.material.set("shader_parameter/oldP", Global.MainPal)
	i.material.set("shader_parameter/newP", palette)
## END of pal_line_change
