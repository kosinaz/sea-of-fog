extends Node2D

var fov = Fov.new()
var walkable_tiles = [7, 8, 9, 16, 18, 19, 21, 26, 27, 32, 33, 34, 35, 36, 38, 39, 40, 41, 42, 46, 47, 49, 50, 51]
var outside_tiles = [7, 9, 19, 21, 26, 32, 33, 34, 35, 36, 38, 39, 40, 41, 42, 49]
var tween = null
var map_position = Vector2()
var up_is_down = false
var left_is_down = false
var right_is_down = false
var down_is_down = false

func _ready():
	$"%Player/Fov".show()
	$"%TileMap".hide()
	$"HUD".show()
	map_position = $"%TileMap".world_to_map($"%Player".position)
	draw_fov()
	$IntroFadeIn.play("intro")
	$Narrator.say("intro")

func _process(_delta):
	if tween != null and tween.is_running():
		return
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_down") or Input.is_action_pressed("ui_up"):
		$"%MovementButtons".hide()
		$"%HideButtons".set_pressed_no_signal(true)
	if Input.is_action_pressed("ui_left") or left_is_down:
		var tile = $"%TileMap".get_cell(map_position.x - 1, map_position.y)
		if walkable_tiles.has(tile):
			map_position.x -= 1
			$Player/AnimatedSprite.play("left")
		else:
			$Player/AnimatedSprite.play("idle_left")
	elif Input.is_action_pressed("ui_right") or right_is_down:
		var tile = $"%TileMap".get_cell(map_position.x + 1, map_position.y)
		if walkable_tiles.has(tile):
			map_position.x += 1
			$Player/AnimatedSprite.play("right")
		else:
			$Player/AnimatedSprite.play("idle_right")
	elif Input.is_action_pressed("ui_up") or up_is_down:
		var tile = $"%TileMap".get_cell(map_position.x, map_position.y - 1)
		if walkable_tiles.has(tile):
			map_position.y -= 1
			$Player/AnimatedSprite.play("up")
		else:
			$Player/AnimatedSprite.play("idle_up")
	elif Input.is_action_pressed("ui_down") or down_is_down:
		var tile = $"%TileMap".get_cell(map_position.x, map_position.y + 1)
		if walkable_tiles.has(tile):
			map_position.y += 1
			$Player/AnimatedSprite.play("down")
		else:
			$Player/AnimatedSprite.play("idle_down")
	else:
		if not $Player/AnimatedSprite.animation.begins_with("idle"):
			$Player/AnimatedSprite.play("idle_" + $Player/AnimatedSprite.animation)
		return
	tween = get_tree().create_tween()
	tween.tween_property($"%Player", "position", $TileMap.map_to_world(map_position), 0.25)
	tween.tween_callback(self, "on_move")
	draw_fov()

func on_move():
	for trigger in $Triggers.get_children():
		if map_position == $TileMap.world_to_map(trigger.position):
			trigger.on_move()

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
	$"%MiniMap".add(current_fov, map_position)

func _on_narrator_finished():
	$"%NarrationContainer".hide()

func _on_fade_in_finished():
	$ColorRect.queue_free()

func _on_up_button_down():
	up_is_down = true

func _on_left_button_down():
	left_is_down = true

func _on_down_button_down():
	down_is_down = true

func _on_right_button_down():
	right_is_down = true

func _on_up_button_up():
	up_is_down = false

func _on_left_button_up():
	left_is_down = false

func _on_down_button_up():
	down_is_down = false

func _on_right_button_up():
	right_is_down = false

func _on_hide_buttons_toggled(button_pressed):
	$"%MovementButtons".visible = not button_pressed

func _on_hide_messages_pressed():
	$"%LogPanel".hide()

func _on_messages_pressed():
	$"%LogPanel".show()
	$"%Log".text = ""
	for line in $"%Narrator".completed:
		$"%Log".text += $"%Narrator".lines[line] + "\n\n"
