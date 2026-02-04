extends Node2D


# WILL MOVE AFTER I TEST!
func floor_pattern(floor_bit) -> void:
	var inst_block = Global.Block.instantiate()
	add_child(inst_block)
	inst_block.position.y = 16.0

	match floor_bit:
		0: # 0000
			print("FLOOR PATTERN OF '00000000000000'")
		1: # 0001
			print("FLOOR PATTERN OF '00000000000011'")
		2: # 0010
			print("FLOOR PATTERN OF '01000000000011'")
		3: # 0011
			print("FLOOR PATTERN OF '01110000000011'")
		4: # 0100
			print("FLOOR PATTERN OF '01111000000011'")
		5: # 0101
			print("FLOOR PATTERN OF '01111111100011'")
		6: # 0110
			print("FLOOR PATTERN OF '01000000011111'")
		7: # 0111
			print("FLOOR PATTERN OF '01110000011111'")
		8: # 1000
			print("FLOOR PATTERN OF '01111000011111'")
		9: # 1001
			print("FLOOR PATTERN OF '01000000111111'")
		10: # 1010
			print("FLOOR PATTERN OF '01000000000000'")
		11: # 1011
			print("FLOOR PATTERN OF '01111000111111'")
		12: # 1100
			print("FLOOR PATTERN OF '01000111111111'")
		13: # 1101
			print("FLOOR PATTERN OF '01001111100011'")
		14: # 1110
			print("FLOOR PATTERN OF '01000111100011'")
		15: # 1111
			print("FLOOR PATTERN OF '01111111111111'")
## END of floor_pattern
