extends Control

var config = ConfigFile.new()
var audio = true
var music = 0

func _ready():
	var result = config.load("user://config.cfg")
	if result == OK:
		audio = config.get_value("settings", "audio", true)
		music = config.get_value("settings", "music", 0)
	$"%Music".volume_db = music if music > -50 and audio else -100
	$"%Audio".set_pressed_no_signal(not audio)

func _on_start_button_down():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://map.tscn")

func _on_audio_button_toggled(button_pressed):
	$"%Music".volume_db = -100 if button_pressed or music == -50 else music
	config.load("user://config.cfg")
	config.set_value("settings", "audio", not button_pressed)
# warning-ignore:return_value_discarded
	config.save("user://config.cfg")
