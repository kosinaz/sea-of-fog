extends Control

func _input(event):
	if event is InputEventMouseMotion:
		return
	if $NarrationContainer.visible:
		return
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://menu.tscn")

func _on_ending_finished():
	$AudioStreamPlayerMusic.volume_db = 0
	$NarrationContainer.hide()
