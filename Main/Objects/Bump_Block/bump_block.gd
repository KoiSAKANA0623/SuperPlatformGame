extends Node2D
class_name Bump_Block

@onready var Anim_Node = $BumpAnim
@onready var Visual_Node = $SpriteObject

var block_pos: int = 0

var y_velocity: float = 0.0


func _physics_process(_delta: float) -> void:
	if visible:
		y_velocity += 0.3125
		global_position.y += y_velocity

	if int(global_position.y/16) >= block_pos:
		queue_free()
	elif global_position.x < Global.camera_pos - 8:
		queue_free()
## END of _physics_process
