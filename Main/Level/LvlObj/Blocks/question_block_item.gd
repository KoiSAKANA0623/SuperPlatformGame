extends Level_Object

## 0=Mushroom, 1=Flower, 2=Coin
@export_range(0,2, 1) var item: int = 2


func _init() -> void:
	lvl_object_type = "QUESTION_BLOCK_ITEM"
## END of _init
