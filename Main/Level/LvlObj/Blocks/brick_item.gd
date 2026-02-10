extends Level_Object

## 0=Mushroom, 1=Flower, 2=Vine, 3=Starman, 4=Multicoin, 5=1UP
@export_range(0,5, 1) var item: int = 4


func _init() -> void:
	lvl_object_type = "BRICK_ITEM"
## END of _init
