extends Node2D

var explored = []
var center = Vector2()

func add(tiles, new_center):
	center = new_center
	for tile in tiles:
		if not explored.has(tile):
			explored.append(tile)
	update()

func _draw():
	var tile_vector = Vector2()
	for tile in explored:
		tile_vector = Vector2(tile.x, tile.y)
		var color = Color.peru
		if $"%TileMap".get_cellv(tile_vector) == 52:
			color = Color.darkblue
		if [8, 18, 19].has($"%TileMap".get_cellv(tile_vector)):
			color = Color.gray
		if [49, 50].has($"%TileMap".get_cellv(tile_vector)):
			color = Color.white
		if [11, 53, 56].has($"%TileMap".get_cellv(tile_vector)):
			color = Color.black
		if [4, 10, 12, 17, 20, 22, 23, 24, 25, 28, 29, 30, 31, 37].has($"%TileMap".get_cellv(tile_vector)):
			color = Color.darkslategray
		draw_rect(Rect2((tile_vector + Vector2(11, 10)) * 3, Vector2(3, 3)), color)
	draw_rect(Rect2((center + Vector2(11, 10)) * 3, Vector2(3, 3)), Color.blue)
