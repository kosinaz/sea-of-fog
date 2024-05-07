extends Control

var config = ConfigFile.new()
var audio = true
var sound = 0
var music = -10
var lesson_id = 1

func _ready():
	var result = config.load("user://config.cfg")
	if result == OK:
		audio = config.get_value("settings", "audio", true)
		sound = config.get_value("settings", "sound", 0)
		music = config.get_value("settings", "music", -10)
		lesson_id = config.get_value("progress", "lesson", 1)
	print(config.get_value("settings", "audio", "audio missing"))
	print(config.get_value("settings", "music", "music missing"))
	print(config.get_value("settings", "sound", "sound missing"))
	print(config.get_value("progress", "lesson", "lesson missing"))
	$AudioStreamPlayerEnding.volume_db = sound if sound > -40 and audio else -100
	$AudioStreamPlayerFullEnding.volume_db = sound if sound > -40 and audio else -100
	$AudioStreamPlayerMusic.volume_db = (music if music > -50 and audio else -100) - 5
	$"%Audio".set_pressed_no_signal(not audio)
	if lesson_id == 12:
		$AudioStreamPlayerFullEnding.play()
		$FullEndingBg.show()
		$NarrationContainer/FullNarration.show()
		$NarrationContainer/Narration.hide()
	else:
		$AudioStreamPlayerEnding.play()
	
func _input(event):
	if event is InputEventMouseMotion:
		return
	if $NarrationContainer.visible:
		return
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://menu.tscn")

func _on_ending_finished():
	var tween = get_tree().create_tween()
	tween.tween_property($AudioStreamPlayerMusic, "volume_db", music, 3)
	$NarrationContainer.hide()

func _on_audio_toggled(button_pressed):
	$AudioStreamPlayerMusic.volume_db = -100 if button_pressed else music - 5
	$AudioStreamPlayerEnding.volume_db = -100 if button_pressed else sound
	$AudioStreamPlayerFullEnding.volume_db = -100 if button_pressed else sound
	config.load("user://config.cfg")
	config.set_value("settings", "audio", not button_pressed)
# warning-ignore:return_value_discarded
	config.save("user://config.cfg")
	print(config.get_value("settings", "audio", "audio missing"))
	print(config.get_value("settings", "music", "music missing"))
	print(config.get_value("settings", "sound", "sound missing"))
	print(config.get_value("progress", "lesson", "lesson missing"))
