extends Node2D
class_name Blocks

const block_col = preload("res://Main/Level/LvlObj/block_collision.tscn")
const item_col = preload("res://Main/Level/LvlObj/item_block_collision.tscn")

var summonables: Dictionary = {
	"Brick_Shard": load("res://Main/Objects/Brick_Break/brick_break.tscn"),
	"Bump_Block": load("res://Main/Objects/Bump_Block/bump_block.tscn")
}

@onready var Visual_Node = $Visual

var palInt: int = 0
var palette: Texture = Global.TILPal0

var sp_col
var col_type:int = 0

const block_coltype: Dictionary = {
	"GROUND": [true,1],
	"BTREE_00": [false], "BTREE_01": [false], "BTREE_02": [false], "BTREE_03": [false],
	"MUSHROOM_00":[true,0], "MUSHROOM_01":[true,0], "MUSHROOM_02":[true,0], "MUSHROOM_03":[false], "MUSHROOM_04":[false],
	"CLOUD": [true,0],
	"BRIDGE_00": [true,0], "BRIDGE_01": [false],
	"BULLET_00": [true,0], "BULLET_01": [true,0], "BULLET_02": [true,0],
	"PULLEY_00": [false], "PULLEY_01": [false], "PULLEY_02": [false], "PULLEY_03": [false],

	"UNDERWATER": [true,0],
	"COIN_UW": [true,2],
	"CORAL": [true,0],
	"WATER_SURFACE": [false], "WATER": [false],
	"PIPE_UW_00": [true,4], "PIPE_UW_01": [true,4],

	"CASTLE": [true,0],
	"AXE": [true,5], "CHAIN": [false],
	"CH_BRIDGE": [true,0],

	"HARDBLOCK": [true,0],
	"BRICK_HI": [true,1], "BRICK": [true,1],
	"Q_BLOCK": [true,1],
	"EMPTY_BLOCK": [true,1],
	"COIN": [true,2],
	"PIPE_00":[true,4], "PIPE_01":[true,4], "PIPE_10":[true,0], "PIPE_11":[true,0],
	"PIPE_04":[true,0], "PIPE_05":[true,0], "PIPE_06":[true,0], "PIPE_07":[true,0], "PIPE_08":[true,0], "PIPE_09":[true,0],
	"POLETOP": [true,3], "POLE": [true,3],

	"BG_BUSH_00": [false], "BG_BUSH_01": [false], "BG_BUSH_02": [false],
	"BG_CLOUD_00": [false], "BG_CLOUD_01": [false], "BG_CLOUD_02": [false],
	"BG_CLOUD_03": [false], 'BG_CLOUD_04': [false], "BG_CLOUD_05": [false],
	"BG_TREE_00": [false], "BG_TREE_01": [false], "BG_TREE_02": [false], "BG_TREE_03": [false],
	"BG_FENCE": [false],
	"BG_MOUNT_00": [false], "BG_MOUNT_01": [false], "BG_MOUNT_02": [false],
	"BG_MOUNT_03": [false], "BG_MOUNT_04": [false], "BG_MOUNT_05": [false],

	"E_CASTLE_00":[false], "E_CASTLE_01":[false], "E_CASTLE_02":[false], "E_CASTLE_03":[false], "E_CASTLE_04":[false],
	"E_CASTLE_05":[false], "E_CASTLE_06":[false]
}


func _ready() -> void:
	for i in Visual_Node.get_children():
		i.material = Global.Pal_Shader.duplicate()
		i.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
		i.texture = Global.CHR_BG
		i.region_enabled = true
		i.region_rect = Rect2(0,0,8,8)
		i.centered = false
## END of _ready


func _process(_delta: float) -> void:
	if global_position.x < Global.camera_pos - 24:
		queue_free()
## END of _process


func build_block(block_tile, t) -> void:
	var b = block_coltype.get(t)
	if b[0]:
		set_collision(b[1])
		col_type = b[1]
	else:
		col_type = -1
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


func set_collision(interactable) -> void:
	match interactable:
		0:
			var inst_col = block_col.instantiate()
			add_child(inst_col)
		1: # Brick/Q-Block interaction
			var inst_col = block_col.instantiate()
			add_child(inst_col)
			var inst_item_col = item_col.instantiate()
			add_child(inst_item_col)
			sp_col = inst_item_col
		2: # Coin
			return
		3: # Flagpole
			return
		4: # Pipe
			var inst_col = block_col.instantiate()
			add_child(inst_col)
			return
		5: # Axe
			return
## END of set_collision


func check_hit() -> void:
	match col_type:
		1:
			if !Global.mario_big:
				bump_block()
				return
			var shard0 = summonables["Brick_Shard"].instantiate()
			shard0.global_position = global_position
			shard0.x_velocity = -1.0
			shard0.y_velocity = -6.0
			Global.main_sprit_n.add_child(shard0)
			var shard1 = summonables["Brick_Shard"].instantiate()
			shard1.global_position = global_position + Vector2(8,0)
			shard1.x_velocity = 1.0
			shard1.y_velocity = -6.0
			Global.main_sprit_n.add_child(shard1)
			var shard2 = summonables["Brick_Shard"].instantiate()
			shard2.global_position = global_position + Vector2(0,8)
			shard2.x_velocity = -1.0
			shard2.y_velocity = -4.0
			Global.main_sprit_n.add_child(shard2)
			var shard3 = summonables["Brick_Shard"].instantiate()
			shard3.global_position = global_position + Vector2(8,8)
			shard3.x_velocity = 1.0
			shard3.y_velocity = -4.0
			Global.main_sprit_n.add_child(shard3)
			queue_free()
## END of check_hit


func bump_block() -> void:
	var bump = summonables["Bump_Block"].instantiate()
	bump.global_position = global_position + Vector2(0,-1)
	bump.block_pos = int(global_position.y/16)
	bump.visible = false
	bump.y_velocity = -2.0
	Global.main_sprit_n.add_child(bump)
	bump.get_node("SpriteObject").anim = 1
	await get_tree().physics_frame
	await get_tree().process_frame
	visible = false
	if bump:
		bump.visible = true
	await get_tree().create_timer(0.2166).timeout
	visible = true
## END of bump_block
