extends Node2D

export var line = ""

func _unhandled_input(_event):
	if $"%Player".position != position:
		return
	$"%Narrator".say(line)
	if line == "mirror room ending":
		$"%TileMap".set_cell(29, 6, 14)
		$"%TileMap".set_cell(26, 20, 9)
	if line == "courtyard ending":
		$"%TileMap".set_cell(2, 46, 21)
