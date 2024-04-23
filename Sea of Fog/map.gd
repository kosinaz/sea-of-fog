extends Node2D

var fov = Fov.new()

func _unhandled_input(event):
	if event.is_action_pressed("ui_up"):
		$"%Player".position.y -= 16
	if event.is_action_pressed("ui_down"):
		$"%Player".position.y += 16
	if event.is_action_pressed("ui_left"):
		$"%Player".position.x -= 16
	if event.is_action_pressed("ui_right"):
		$"%Player".position.x += 16
	var map_position = $TileMap.world_to_map($"%Player".position)
	var walls = $TileMap.get_used_cells_by_id(4)
	var current_fov = fov.calculate(map_position.x, map_position.y, 7, walls)
	var tile = $"%TileMap".get_cell(map_position.x, map_position.y)
	if tile == 2:
		$"%Player/Sprite".modulate = Color(1, 1, 1, 1)
	else:
		$"%Player/Sprite".modulate = Color(0, 0, 0, 1)
	$"%TileMap2".clear()
	for x in range(-16, 16):
		for y in range(-8, 8):
			$"%TileMap2".set_cell(map_position.x + x, map_position.y + y, 5 if tile == 2 else 0)
	for cell in current_fov:
		$"%TileMap2".set_cell(cell.x, cell.y, $"%TileMap".get_cell(cell.x, cell.y), false, false, false, $"%TileMap".get_cell_autotile_coord(cell.x, cell.y))
