extends Node2D

var fov = Fov.new()
var walkable_tiles = [7, 8, 9]
var outside_tiles = [7, 9]

func _ready():
	$"%Player/Fov".show()
	$TileMap.hide()
	draw_fov()
	$IntroFadeIn.play("intro")
	$Narrator.say(0)

func _unhandled_input(event):
	var map_position = $TileMap.world_to_map($"%Player".position)
	if event.is_action_pressed("ui_up"):
		var tile = $"%TileMap".get_cell(map_position.x, map_position.y - 1)
		if walkable_tiles.has(tile):
			$"%Player".position.y -= 16
	if event.is_action_pressed("ui_down"):
		var tile = $"%TileMap".get_cell(map_position.x, map_position.y + 1)
		if walkable_tiles.has(tile):
			$"%Player".position.y += 16
	if event.is_action_pressed("ui_left"):
		var tile = $"%TileMap".get_cell(map_position.x - 1, map_position.y)
		if walkable_tiles.has(tile):
			$"%Player".position.x -= 16
	if event.is_action_pressed("ui_right"):
		var tile = $"%TileMap".get_cell(map_position.x + 1, map_position.y)
		if walkable_tiles.has(tile):
			$"%Player".position.x += 16
	draw_fov()
	
func draw_fov():
	var map_position = $TileMap.world_to_map($"%Player".position)
	var walls = $TileMap.get_used_cells_by_id(4)
	walls.append_array($TileMap.get_used_cells_by_id(10))
	var current_fov = fov.calculate(map_position.x, map_position.y, 7, walls)
	var tile = $"%TileMap".get_cell(map_position.x, map_position.y)
	if outside_tiles.has(tile):
		$"%Player/Fov".modulate = Color(1, 1, 1, 1)
	else:
		$Narrator.say(1)
		$"%Player/Fov".modulate = Color(0, 0, 0, 1)
	$"%TileMap2".clear()
	for x in range(-16, 16):
		for y in range(-8, 8):
			$"%TileMap2".set_cell(map_position.x + x, map_position.y + y, 11 if not outside_tiles.has(tile) else 0)
	for cell in current_fov:
		$"%TileMap2".set_cell(cell.x, cell.y, $"%TileMap".get_cell(cell.x, cell.y), false, false, false, $"%TileMap".get_cell_autotile_coord(cell.x, cell.y))

func _on_narrator_finished():
	$"%NarrationContainer".hide()
