extends Level_Object

## 0=Mushroom/Flower, 1=Coin, 
@export_range(0,1, 1) var item: int = 1


func _init() -> void:
	lvl_object_type = "QUESTION_BLOCK_ITEM"
## END of _init
