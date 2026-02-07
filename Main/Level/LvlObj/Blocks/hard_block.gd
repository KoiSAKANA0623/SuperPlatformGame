extends Level_Object

@export_range(1,16, 1) var range: int = 1

## False = Column, True = Row
@export var col_or_row: bool = false


func _init() -> void:
	lvl_object_type = "HARDBLOCK"
## END of _init
