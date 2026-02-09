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

var rising: int = 52


func _physics_process(_delta: float) -> void:
	if rising > 0:
		z_index = -10
		rising -= 1
		if rising % 4 == 0:
			global_position.y -= 1
		if rising == 1:
			reparent(Global.main_sprit_n)
		return
	x_velocity = direction

	if WallCol.is_colliding():
		direction *= -1
		WallCol.target_position.x = 8 * direction
		global_position.x = WallCol.get_collision_point().x - (8 - (8 * direction))
	var a = round(global_position.y/16)*16
	var b = (round(FloorCol.get_collision_point().y) - 15)
	var vel_clamp = clamp(y_velocity,0.0,8.0)
	FloorCol.target_position.y = vel_clamp
	if y_velocity >= 0.0:
		if FloorCol.is_colliding():
			if (a-b) <= 2.0:
				is_grounded = true
				global_position.y = (round(FloorCol.get_collision_point().y/16)*16 - 15)
		else:
			is_grounded = false

	global_position.x += x_velocity

	if y_velocity > 3:
		y_velocity = 3
	if is_grounded:
		y_velocity = 0
	else:
		y_velocity += 0.3125

	global_position.y += y_velocity

	if global_position.y > 240.0:
		queue_free()
	elif global_position.x < Global.camera_pos - 95:
		queue_free()
## END of _physics_process
