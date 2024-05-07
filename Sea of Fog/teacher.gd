extends MarginContainer

var config = ConfigFile.new()

var lessons = {
	"mirror room ending": "Answers often emerge from unexpected places.",
	"courtyard ending": "Time is endless, flowing like water; its beauty lie in close admiration.",
	"disc room ending": "Success arises from aligning life's priorities.",
	"seasons altar ending": "Follow the rules of nature as time goes by, and you will reap the rewards of harmony.",
	"seed room ending": "Patience fosters growth; allow yourself the time to flourish.",
	"colonnade ending": "You hold your future in your hand; it's yours to shape as you choose.",
	"square ending": "Adapt to the unpredictable nature of the future.",
	"maze ending": "Discover your own light amidst darkness, guiding your path even in the most obscure moments.",
	"clock tower ending": "Embrace the passage of time, for with each tick of the clock, new opportunities unfold.",
	"invention hall ending": "Innovation thrives in the face of challenge; adapt and conquer.",
	"flower gate ending": "Exploration yields treasures unseen.",
	"reflection field ending": "Embrace self-reflection to uncover hidden strengths and forge a path forward.",
}

var lesson_id = 0

func present(lesson):
	if lesson == "ending":
		return
	if lesson == "full ending":
		return
	if lesson == "invention hall strength ending":
		return
	if lesson == "invention hall speed ending":
		return
	if lesson == "invention hall cunning ending":
		return
	lesson_id += 1
	show()
	$Panel/Lesson.text = "Lesson " + str(lesson_id) + "/" + str(lessons.size()) + " Learned: \n" + lessons[lesson]
	$Timer.start()
	$"%Fanfare".play()
	config.load("user://config.cfg")
	config.set_value("progress", "lesson", lesson_id)
	config.save("user://config.cfg")
	var i = lessons.keys().find(lesson)
	$"%LessonsWindow".add_lesson(i, lessons[lesson])

func _on_timer_timeout():
	hide()
