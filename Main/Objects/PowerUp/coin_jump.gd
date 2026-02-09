extends Node2D
class_name CoinJumping

@onready var Anim_Node = $CoinAnim
@onready var Visual_Node = $CoinObject

var y_velocity: float = 0.0


func _physics_process(_delta: float) -> void:
	y_velocity += 0.3125
	if y_velocity >= 5:
		queue_free()

	global_position.y += y_velocity

	if global_position.y > 240.0:
		queue_free()
	elif global_position.x < Global.camera_pos - 16:
		queue_free()
## END of _physics_process
