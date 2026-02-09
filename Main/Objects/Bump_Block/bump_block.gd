extends Node2D
class_name Bump_Block

@onready var Anim_Node = $BumpAnim
@onready var Visual_Node = $SpriteObject

var block_pos: int = 0

var y_velocity: float = 0.0

var palette_id: int = 0


func _ready() -> void:
	Visual_Node.pal_change(palette_id)
## END of _ready

func _physics_process(_delta: float) -> void:
	y_velocity += 0.3125
	global_position.y += y_velocity

	if global_position.y >= (block_pos*16)+2:
		queue_free()
	elif global_position.x < Global.camera_pos - 8:
		queue_free()
## END of _physics_process
