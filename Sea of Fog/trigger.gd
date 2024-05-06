extends Node2D

export var line = ""
export var repeat = false

func on_move():
	if line == "ending":
	# warning-ignore:return_value_discarded
		get_tree().change_scene("res://victory.tscn")
	$"%Narrator".say(line, repeat)
	if line == "mirror room ending":
		$"%TileMap".set_cell(29, 6, 14)
		$"%TileMap2".set_cell(29, 6, 14)
		$"%TileMap".set_cell(26, 20, 9)
		$"%Narrator".disable("door")
		get_parent().get_parent().walls.erase(Vector2(26, 20))
	if line == "courtyard ending":
		$"%TileMap".set_cell(2, 46, 21)
		$"%TileMap2".set_cell(2, 46, 21)
	if not $"%Narrator".disabled.has("disc room riddle") and ["disc room health", "disc room happiness", "disc room love", "disc room growth"].has(line):
		var tile = $"%TileMap".world_to_map(position)
		var tile_id = ($"%TileMap".get_cell(tile.x, tile.y - 1) + 1) % 4 + 28
		$"%TileMap".set_cell(tile.x, tile.y - 1, tile_id)
		$"%TileMap2".set_cell(tile.x, tile.y - 1, tile_id)
		for x in range(9, 14):
			if $"%TileMap".get_cell(x, 8) != 30:
				return
		$"%Narrator".say("disc room ending")
		$"%TileMap".set_cell(11, 0, 9)
		$"%Narrator".disable("bridge")
	if not $"%Narrator".disabled.has("seasons altar riddle") and ["seasons altar spring", "seasons altar summer", "seasons altar autumn", "seasons altar winter"].has(line):
		var tile = $"%TileMap".world_to_map(position)
		var tile_id = $"%TileMap".get_cell(tile.x, tile.y)
		if tile_id > 38:
			return
		$"%TileMap".set_cell(tile.x, tile.y, tile_id + 7)
		$"%TileMap2".set_cell(tile.x, tile.y, tile_id + 7)
		if $"%TileMap".get_cell(-4, 6) == 39 and $"%TileMap".get_cell(-6, 6) == 40 and $"%TileMap".get_cell(-6, 4) == 41 and $"%TileMap".get_cell(-4, 4) == 42:
			$"%Narrator".say("seasons altar ending")
			$"%TileMap".set_cell(-5, 5, 38)
			$"%TileMap2".set_cell(-5, 5, 38)
		if tile_id == 32 and $"%TileMap".get_cell(-4, 4) == 35:
			$"%TileMap".set_cell(-6, 6, 33)
			$"%TileMap2".set_cell(-6, 6, 33)
			$"%TileMap".set_cell(-6, 4, 34)
			$"%TileMap2".set_cell(-6, 4, 34)
		if tile_id == 33 and $"%TileMap".get_cell(-4, 6) == 32:
			$"%TileMap".set_cell(-6, 4, 34)
			$"%TileMap2".set_cell(-6, 4, 34)
			$"%TileMap".set_cell(-4, 4, 35)
			$"%TileMap2".set_cell(-4, 4, 35)
		if tile_id == 34 and $"%TileMap".get_cell(-6, 6) == 33:
			$"%TileMap".set_cell(-4, 6, 32)
			$"%TileMap2".set_cell(-4, 6, 32)
			$"%TileMap".set_cell(-4, 4, 35)
			$"%TileMap2".set_cell(-4, 4, 35)
		if tile_id == 35 and $"%TileMap".get_cell(-6, 4) == 34:
			$"%TileMap".set_cell(-4, 6, 32)
			$"%TileMap2".set_cell(-4, 6, 32)
			$"%TileMap".set_cell(-6, 6, 33)
			$"%TileMap2".set_cell(-6, 6, 33)
	if line == "seed room pedestal" and $"%Narrator".disabled.has("seasons altar riddle") and not $"%Narrator".disabled.has("seed room ending"):
		$"%TileMap".set_cell(32, 29, 44)
		$"%TileMap2".set_cell(32, 29, 44)
		$"%Narrator".say("seed room seed")
		$"%Narrator".disable("seed room pedestal")
	if line == "seed room plate" and $"%Narrator".disabled.has("seed room seed"):
		$"%TileMap".set_cell(32, 27, 47)
		$"%TileMap2".set_cell(32, 27, 47)
		$"%Narrator".say("seed room plate moving", true)
		$"%Timer".start(0.0)
	if line == "seed room plate off" and $"%TileMap".world_to_map(position) != Vector2(32, 27) and not $"%Narrator".disabled.has("seed room ending"):
		$"%TileMap".set_cell(32, 27, 46)
		$"%TileMap2".set_cell(32, 27, 46)
		$"%Timer".stop()
	if line == "colonnade statue" and $"%Narrator".disabled.has("courtyard ending"):
		$"%TileMap".set_cell(39, 31, 9)
		$"%TileMap2".set_cell(39, 31, 9)
		$"%Narrator".say("colonnade ending")
		$"%Narrator".disable("colonnade door")
		get_parent().get_parent().walls.erase(Vector2(39, 31))
		get_parent().get_parent().draw_fov()
	if line == "square ending":
		for x in range(41, 46):
			for y in range(23, 28):
				$"%TileMap".set_cell(x, y, 9)
				$"%TileMap2".set_cell(x, y, 9)
		$"%SquareTimer".stop()
	if line == "maze ending":
		$"%TileMap".set_cell(37, 5, 9)
		$"%TileMap2".set_cell(37, 5, 9)
		

func _on_timer_timeout():
		$"%TileMap".set_cell(32, 29, 45)
		$"%TileMap2".set_cell(32, 29, 45)
		$"%TileMap".set_cell(31, 40, 9)
		$"%Narrator".say("seed room ending")
		$"%Narrator".disable("seed room plate moving")
