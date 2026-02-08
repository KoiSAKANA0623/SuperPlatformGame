extends Node2D
class_name Brick_Shard

@onready var Anim_Node = $BrickAnim
@onready var Visual_Node = $BrickVisuals

var x_velocity: float = 0.0
var y_velocity: float = 0.0


func _physics_process(_delta: float) -> void:
	global_position.x += x_velocity

	y_velocity += 0.3125
	if y_velocity > 8.0:
		y_velocity = 8.0
	global_position.y += y_velocity

	if global_position.y > 240.0:
		queue_free()
	elif global_position.x < Global.camera_pos:
		queue_free()

	Visual_Node.anim = 0
## END of _physics_process
