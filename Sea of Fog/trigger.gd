extends Node2D

export var line = ""
export var repeat = false

func _unhandled_input(event):
	if not (event.is_action_released("ui_down") or event.is_action_released("ui_up") or event.is_action_released("ui_left") or event.is_action_released("ui_right")):
		return
	if $"%Player".position != position:
		return
	$"%Narrator".say(line, repeat)
	if line == "mirror room ending":
		$"%TileMap".set_cell(29, 6, 14)
		$"%TileMap".set_cell(26, 20, 9)
	if line == "courtyard ending":
		$"%TileMap".set_cell(2, 46, 21)
	if not $"%Narrator".completed.has("disc room riddle") and ["disc room health", "disc room happiness", "disc room love", "disc room growth"].has(line):
		var tile = $"%TileMap".world_to_map(position)
		$"%TileMap".set_cell(tile.x, tile.y - 1, ($"%TileMap".get_cell(tile.x, tile.y - 1) + 1) % 4 + 28)
		for x in range(9, 14):
			if $"%TileMap".get_cell(x, 8) != 30:
				return
		$"%Narrator".say("disc room ending")
		$"%TileMap".set_cell(4, -6, 9)
		$"%Narrator".completed.append_array(["disc room health", "disc room happiness", "disc room love", "disc room growth", "disc room riddle", "disc room life", "bridge"])
	if not $"%Narrator".completed.has("seasons altar riddle") and ["seasons altar spring", "seasons altar summer", "seasons altar autumn", "seasons altar winter"].has(line):
		var tile = $"%TileMap".world_to_map(position)
		var tile_id = $"%TileMap".get_cell(tile.x, tile.y)
		if tile_id > 38:
			return
		$"%TileMap".set_cell(tile.x, tile.y, tile_id + 7)
		if $"%TileMap".get_cell(-4, 6) == 39 and $"%TileMap".get_cell(-6, 6) == 40 and $"%TileMap".get_cell(-6, 4) == 41 and $"%TileMap".get_cell(-4, 4) == 42:
			$"%Narrator".completed.append_array(["seasons altar riddle", "seasons altar spring", "seasons altar summer", "seasons altar autumn", "seasons altar winter"])
			$"%Narrator".say("seasons altar ending")
			$"%TileMap".set_cell(-5, 5, 38)
		if tile_id == 32 and $"%TileMap".get_cell(-4, 4) == 35:
			$"%TileMap".set_cell(-6, 6, 33)
			$"%TileMap".set_cell(-6, 4, 34)
		if tile_id == 33 and $"%TileMap".get_cell(-4, 6) == 32:
			$"%TileMap".set_cell(-6, 4, 34)
			$"%TileMap".set_cell(-4, 4, 35)
		if tile_id == 34 and $"%TileMap".get_cell(-6, 6) == 33:
			$"%TileMap".set_cell(-4, 6, 32)
			$"%TileMap".set_cell(-4, 4, 35)
		if tile_id == 35 and $"%TileMap".get_cell(-6, 4) == 34:
			$"%TileMap".set_cell(-4, 6, 32)
			$"%TileMap".set_cell(-6, 6, 33)
		
		
