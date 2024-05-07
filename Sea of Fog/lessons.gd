extends MarginContainer

var lessons = []

func _ready():
	for i in range(12):
		lessons.append(str(i + 1) + ". ?")
	add_lesson(0, "?")

func add_lesson(i, text):
	lessons[i] = str(i + 1) + ". " + text
	$"%List".text = ""
	for j in range(12):
		$"%List".text += lessons[j] + "\n"

func _on_close_pressed():
	hide()
