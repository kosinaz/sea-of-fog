extends MarginContainer

var lessons = {
	"mirror room ending": "Answers often emerge from unexpected places.",
	"courtyard ending": "Time is endless, flowing like water; its beauty lie in close admiration.",
	"disc room ending": "Success arises from aligning life's priorities.",
	"seasons altar ending": "Follow the rules of nature as time goes by, and you will reap the rewards of harmony.",
	"seed room ending": "Patience fosters growth; allow yourself the time to flourish.",
	"colonnade ending": "You hold your future in your hand; it's yours to shape as you choose.",
	"square ending": "Adapt to the unpredictable nature of the future.",
	"maze ending": "Discover your own light amidst darkness, guiding your path even in the most obscure moments.",
	"cave ending": "Trust in your inner guidance to lead you through the shadows.",
}

var lesson_id = 1

func present(lesson):
	if lesson == "ending":
		return
	show()
	$Panel/Lesson.text = "Lesson " + str(lesson_id) + "/" + str(lessons.size()) + " Learned: \n" + lessons[lesson]
	$Timer.start()
	$"%Fanfare".play()
	lesson_id += 1

func _on_timer_timeout():
	hide()
