extends Node2D

var fov = Fov.new()
var walkable_tiles = [7, 8, 9, 16, 18, 19, 21, 26, 27, 32, 33, 34, 35, 36, 38, 39, 40, 41, 42, 46, 47, 49, 50, 51]
var outside_tiles = [7, 9, 19, 21, 26, 32, 33, 34, 35, 36, 38, 39, 40, 41, 42, 49]
var tween = null
var map_position = Vector2()
var target_position = Vector2()

func _ready():
	$"%Player/Fov".show()
	$TileMap.hide()
	map_position = $TileMap.world_to_map($"%Player".position)
	draw_fov()
	$IntroFadeIn.play("intro")
	$Narrator.say("intro")

func _process(_delta):
	if tween != null and tween.is_running():
		return
	if Input.is_mouse_button_pressed(1):
		target_position = $TileMap.world_to_map(get_global_mouse_position())
	else:
		return
	var new_map_position = map_position
	if target_position.x < map_position.x:
		var tile = $"%TileMap".get_cell(map_position.x - 1, map_position.y)
		if walkable_tiles.has(tile):
			new_map_position.x -= 1
	if target_position.x > map_position.x:
		var tile = $"%TileMap".get_cell(map_position.x + 1, map_position.y)
		if walkable_tiles.has(tile):
			new_map_position.x += 1
	if target_position.y < map_position.y:
		var tile = $"%TileMap".get_cell(map_position.x, map_position.y - 1)
		if walkable_tiles.has(tile):
			new_map_position.y -= 1
	if target_position.y > map_position.y:
		var tile = $"%TileMap".get_cell(map_position.x, map_position.y + 1)
		if walkable_tiles.has(tile):
			new_map_position.y += 1
	if new_map_position.x == map_position.x and new_map_position.y != map_position.y:
		map_position.y = new_map_position.y
	elif new_map_position.x != map_position.x and new_map_position.y == map_position.y:
		map_position.x = new_map_position.x
	elif abs(target_position.x - map_position.x) > abs(target_position.y - map_position.y):
		map_position.x = new_map_position.x
	else:
		map_position.y = new_map_position.y
	tween = get_tree().create_tween()
	tween.tween_property($"%Player", "position", $TileMap.map_to_world(map_position), 0.25)
	draw_fov()
	
func draw_fov():
	var walls = $TileMap.get_used_cells_by_id(4)
	walls.append_array($TileMap.get_used_cells_by_id(10))
	walls.append_array($TileMap.get_used_cells_by_id(12))
	walls.append_array($TileMap.get_used_cells_by_id(17))
	walls.append_array($TileMap.get_used_cells_by_id(23))
	walls.append_array($TileMap.get_used_cells_by_id(24))
	walls.append_array($TileMap.get_used_cells_by_id(25))
	walls.append_array($TileMap.get_used_cells_by_id(28))
	walls.append_array($TileMap.get_used_cells_by_id(29))
	walls.append_array($TileMap.get_used_cells_by_id(30))
	walls.append_array($TileMap.get_used_cells_by_id(31))
	var current_fov = fov.calculate(map_position.x, map_position.y, 7, walls)
	var tile = $"%TileMap".get_cell(map_position.x, map_position.y)
	if outside_tiles.has(tile):
		$"%Player/Fov".modulate = Color(1, 1, 1, 1)
	else:
		$"%Player/Fov".modulate = Color(0, 0, 0, 1)
	$"%TileMap2".clear()
	for x in range(-16, 16):
		for y in range(-8, 8):
			$"%TileMap2".set_cell(map_position.x + x, map_position.y + y, 11 if not outside_tiles.has(tile) else 0)
	for cell in current_fov:
		$"%TileMap2".set_cell(cell.x, cell.y, $"%TileMap".get_cell(cell.x, cell.y), false, false, false, $"%TileMap".get_cell_autotile_coord(cell.x, cell.y))

func _on_narrator_finished():
	$"%NarrationContainer".hide()

func _on_fade_in_finished():
	$ColorRect.queue_free()
