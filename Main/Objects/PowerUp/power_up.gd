extends Node2D
class_name PowerUp

@onready var Anim_Node = $PowerAnim
@onready var Visual_Node = $PowerObject

@onready var FloorCol = $PowerCollision/FloorCast
@onready var WallCol = $PowerCollision/WallCast

var x_velocity: float = 0.0
var y_velocity: float = 0.0

var is_grounded: bool = false
var direction: int = 1

var rising: int = 48

var type: int = 0
var pal: int = 0


func _ready() -> void:
	if type == 0 || type == 1:
		if Global.mario_big:
			type = 1
			Visual_Node.pal_change(1)
		else:
			type = 0
			Visual_Node.pal_change(2)
	elif type == 3 || type == 5:
		Visual_Node.pal_change(1)
	Visual_Node.anim = type
## END of _ready


func _physics_process(_delta: float) -> void:
	if type == 1 || type == 3:
		pal += 1
		if pal >= 8:
			pal = 0
		var pal_in = pal/2
		if type == 3:
			Visual_Node.pal_change(pal_in)
		else:
			Visual_Node.get_child(0).pal_line_change(pal_in)
			Visual_Node.get_child(1).pal_line_change(pal_in)


	if rising > 0:
		z_index = -10
		rising -= 1
		if rising % 4 == 0:
			global_position.y -= 1
		if rising == 1:
			reparent(Global.main_sprit_n)
		return
	if type == 0 || type == 3 || type == 5:
		x_velocity = direction
	else:
		x_velocity = 0

	WallCol.global_position.x = int((global_position.x+16)/16)*16 + (8 * direction)
	WallCol.global_position.y = int((global_position.y+14)/16)*16 + 8
	if WallCol.has_overlapping_bodies():
		direction *= -1
		global_position.x = (WallCol.global_position.x - 8) + (16 * direction)
		WallCol.global_position.x = int((global_position.x+16)/16)*16 + (8 * direction)
	var a = round(global_position.y/16)*16
	var b = (round(FloorCol.get_collision_point().y) - 15)
	var vel_clamp = clamp(y_velocity,0.0,8.0)
	FloorCol.target_position.y = vel_clamp
	if direction == 1:
		FloorCol.global_position.x = int((global_position.x+11)/16)*16 + (8 * direction)
	else:
		FloorCol.global_position.x = int((global_position.x+21)/16)*16 + (8 * direction)
	if y_velocity >= 0.0 && type != 1:
		if FloorCol.is_colliding():
			if (a-b) <= 2.0:
				if type == 3:
					y_velocity = -3
				else:
					is_grounded = true
				global_position.y = (round(FloorCol.get_collision_point().y/16)*16 - 15)
		else:
			is_grounded = false

	global_position.x += x_velocity

	if y_velocity > 3:
		y_velocity = 3
	if is_grounded || type == 1:
		y_velocity = 0
	else:
		if type == 3:
			y_velocity += 0.109375
		else:
			y_velocity += 0.3125

	global_position.y += y_velocity

	if global_position.y > 240.0:
		queue_free()
	elif global_position.x < Global.camera_pos - 95:
		queue_free()
## END of _physics_process
