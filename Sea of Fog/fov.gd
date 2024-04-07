extends TileMap

var start_x : int
var start_y : int
var width : int 
var height: int 
var radius : float
onready var walls = get_used_cells_by_id(4)
var map = {}

func _unhandled_key_input(_event):
	$"%TileMap2".clear()
	map = {}
	randomize()
	var floors = get_used_cells_by_id(3)
	var start = floors[randi() % floors.size()]
	calculate(start.x, start.y, 6)
	for cell in map:
		$"%TileMap2".set_cell(cell.x, cell.y, get_cell(cell.x, cell.y), false, false, false, get_cell_autotile_coord(cell.x, cell.y))
	$"%TileMap2".set_cell(start.x, start.y, 0)

func calculate(_start_x : int, _start_y : int, _radius : float) -> void:
	var diagonals = [Vector2(1, 1), Vector2(-1, -1), Vector2(1, -1), Vector2(-1, 1)]
	start_x = _start_x
	start_y = _start_y
	radius = _radius
	map[Vector2(start_x, start_y)] = "visible"
	for d in diagonals:
		cast_light(1, 1.0, 0.0, 0, d.x, d.y, 0)
		cast_light(1, 1.0, 0.0, d.x, 0, 0, d.y)

func cast_light(row: int, start: float, end : float, xx : int, xy : int, yx : int, yy : int):
	var new_start : float = 0.0
	if start < end:
		return
	var blocked : bool = false
	for distance in range(row, int(radius) + 1):
		if blocked:
			break
		var delta_y : int = -distance
		for delta_x in range(-distance, 1):
			var current_x : int = start_x + delta_x * xx + delta_y * xy
			var current_y : int = start_y + delta_x * yx + delta_y * yy
			var left_slope : float = (delta_x - 0.5) / (delta_y + 0.5)
			var right_slope : float = (delta_x + 0.5) / (delta_y - 0.5)
			if start < right_slope:
				continue
			elif end > left_slope:
				break
			if (sqrt(delta_x * delta_x + delta_y * delta_y) <= radius):
				map[Vector2(current_x, current_y)] = "visible"
			if blocked:
				if walls.has(Vector2(current_x, current_y)):
					new_start = right_slope
				else:
					blocked = false
					start = new_start
			else:
				if walls.has(Vector2(current_x, current_y)) && distance < radius:
					blocked = true
					cast_light(distance + 1, start, left_slope, xx, xy, yx, yy)
					new_start = right_slope
