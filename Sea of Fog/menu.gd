extends Control

func _on_start_button_down():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://map.tscn")
