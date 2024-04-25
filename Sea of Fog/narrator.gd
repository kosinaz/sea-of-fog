extends AudioStreamPlayer

var completed = []
var lines = [
	"intro",
	"entrance",
]
var line_resources = []

func _ready():
	for line in lines:
		line_resources.append(load("res://" + line + ".mp3"))

func say(line, once = true):
	if completed.has(line):
		return
	stream = line_resources[line]
	.play()
	print(playing)
	if once:
		completed.append(line)
	
