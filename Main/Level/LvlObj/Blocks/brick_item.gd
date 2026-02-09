extends Level_Object

## 0=Mushroom/Flower, 1=Vine, 2=Starman, 3=Multicoin, 4=1UP
@export_range(0,4, 1) var item: int = 3


func _init() -> void:
	lvl_object_type = "BRICK_ITEM"
## END of _init
