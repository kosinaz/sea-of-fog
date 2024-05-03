extends MarginContainer

signal sound_changed
signal music_changed

var config = ConfigFile.new()

func _ready():
	var result = config.load("user://config.cfg")
	if result == OK:
		var sound = config.get_value("settings", "sound")
		$"%SoundVolume".value = sound if sound > -100 else -40
		var music = config.get_value("settings", "music")
		$"%MusicVolume".value = music if music > -100 else -50

func _on_close_settings_pressed():
	hide()
	get_tree().paused = false

func _on_restart_button_pressed():
	get_tree().paused = false
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()

func _on_sound_volume_value_changed(value):
	emit_signal("sound_changed", value)

func _on_music_volume_value_changed(value):
	emit_signal("music_changed", value)
