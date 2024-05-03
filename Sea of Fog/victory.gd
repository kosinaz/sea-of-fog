extends Control

func _input(event):
	if event is InputEventMouseMotion:
		return
	if $NarrationContainer.visible:
		return
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://menu.tscn")

func _on_ending_finished():
	var tween = get_tree().create_tween()
	tween.tween_property($AudioStreamPlayerMusic, "volume_db", 0, 3)
	$NarrationContainer.hide()
