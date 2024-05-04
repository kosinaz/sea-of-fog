extends AudioStreamPlayer

var completed = []
var disabled = []

var lines = {
	"intro": "Hours have passed since the battle's end. I've wandered aimlessly, calling out for my squad, but all I hear is silence. Unable to scale the treacherous mountainsides, I'm left with no choice but to delve deeper into this Sea of Fog.",
	"ending": "After countless trials, I stumble upon a stairway. Without hesitation, I ascend, hoping to finally reach the mountain's summit. And then, as I gaze down into the depths of the valley, the undeniable truth reveals itself... This world is not the one I left behind. It's a different one, shrouded in truly endless fog and crowned with alien mountains. Yet, instead of despair, a sense of contentment washes over me. Accepting my fate, I release the futile pursuit of my past. Once more, I choose to press forward, delving deeper into the unknown, eager to uncover its mysteries and shape my own destiny. For I am, and always will be, a wanderer above the sea of fog...",
	"entrance": "A tunnel? It's ancient, but... perhaps it's a path to escape.",
	"bridge": "There's a bridge below, but I can't see any way to activate the mechanism and bring it back up.",
	"door": "A door. There must be some way to open it.",
	"mirror room intro": "As I step into the dimly lit chamber, a cracked mirror catches my eye. A pile of rubble occupies one corner, two weathered barrels rest in another, and near the entrance, a rusted iron grate lies embedded in the floor.",
	"mirror room ending": "Among the debris, I uncover a hidden lever. As I pull it, a distant rumble echoes through the chamber.",
	"mirror room mirror": "The distorted images staring back at me offer no answers.",
	"mirror room barrels": "The barrels sit empty. Their contents are long decayed.",
	"mirror room grate": "Despite my efforts, I find no means to open the iron grate.",
	"courtyard intro": "In the fog-shrouded courtyard, an ancient statue loom ominously. A weathered fountain stands in the center, while along one wall, a mural tells the tales of a forgotten civilization.",
	"courtyard ending": "In the fountain, atop the central pedestal, I find a loose crystal orb. I decide to take it with me.",
	"courtyard statue": "The statue, though imposing, offers no clues for my journey.",
	"courtyard mural": "The faded mural yields no answers, its meaning lost to time.",
	"disc room intro": "As I step into the small room, I notice five discs embedded in the wall, each adorned with symbols. Nearby, mysterious writing graces the floor...",
	"disc room ending": "As the discs align, the ground trembles, accompanied by a distant rumble echoing from outside.",
	"disc room riddle": "\"Upon the wall, the glyphs align, to reveal the way, by design.\"",
	"disc room health": "Health",
	"disc room happiness": "Happiness",
	"disc room love": "Love",
	"disc room growth": "Growth",
	"disc room life": "Life... Hmm... I can't move it.",
	"seasons altar intro": "In a secluded glade, I stumble upon an altar. A small chest rests at its center, flanked by stone plates adorned with symbols. Beside them stands an obelisk, its inscription catching my eye.",
	"seasons altar ending": "The chest swings open, unveiling a mysterious black gem. I quickly take hold of it.",
	"seasons altar riddle": "\"In nature's dance, I play my part. Each season brings its own unique art. To unlock the treasure, heed this decree: Step on the stones in order to see.\"",
	"seasons altar winter": "Winter",
	"seasons altar spring": "Spring",
	"seasons altar summer": "Summer",
	"seasons altar autumn": "Autumn",
	"seasons altar chest": "I can't open it.",
	"seed room intro": "As I step into the chamber, the air feels heavy with the weight of time. In the center of the room, a bare pedestal stands beneath a shaft of weak sunlight, casting a gentle glow. In front of it, a small stone plate, adorned with the symbol of time. A canal runs through the middle of the room, flowing past the pedestal like a river.",
	"seed room ending": "Time stretches endlessly as the plate slowly descends, each second feeling like an eternity. At last, it comes to a stop, and in the next instant, the pedestal begins to rise, sealing the gap in the ceiling. The air fills with the sound of heavy rocks shifting outside.",
	"seed room pedestal": "Upon closer examination, I discover a gemstone shape carved into the top of the pedestal.",
	"seed room seed": "I place the black gem into the pedestal, then hear a faint clicking sound emanating from under the stone plate.",
	"seed room plate": "I step on the plate, but to my surprise, it remains unmoved. It seems there are hidden mechanics at play preventing its activation.",
	"seed room plate moving": "I step on the plate, feeling it slowly begin to descend beneath my weight.",
	"colonnade intro": "As I ascend the mountainside, I come upon an ancient colonnade. In the center, a sitting statue gazes intently at its open palm, as if expecting something to be placed within. Behind it, stands a massive stone door, hinting at secrets beyond.",
	"colonnade ending": "As I place the crystal orb into the hand of the statue, the heavy stone door behind it begins to slowly descend into the ground, revealing a long staircase.",
	"colonnade statue": "Examining the statue's outstretched palm, it appears perfectly shaped to hold an orb of some kind.",
	"colonnade door": "The door stands tall and forbidding, closed tight, guarding its mysteries. I try to open it, but it remains steadfast, refusing to yield.",
	"maze intro": "As I step into the chamber, darkness envelops me like a thick cloak. There's no discernible path ahead, only the faint glimmer of light in the distance.",
	"maze ending": "Stepping into the light, a hidden pressure plate beneath my foot begins to shift, accompanied by the distant sound of moving rocks and the gentle flow of water. Another bridge, no doubt, ascends from the river below.",
	"maze riddle": "In the depths of darkness, where shadows thrive, find your own light to help you survive."
}

var line_resources = {}

func _ready():
	for line in lines:
		line_resources[line] = load("res://audio/" + line + ".mp3")

func say(line, repeat = false):
	if not lines.has(line):
		return
	if disabled.has(line):
		return
	if line.ends_with("ending"):
		$"%Teacher".present(line)
		disable_room(line.trim_suffix(" ending"))
	$"%NarrationContainer".show()
	$"%Narration".text = lines[line]
	stream = line_resources[line]
	.play()
	complete(line)
	if not repeat:
		disable(line)
	
func complete(line):
	if completed.has(line):
		return
	completed.append(line)
	
func disable(line):
	if not lines.has(line):
		return
	if disabled.has(line):
		return
	disabled.append(line)

func disable_room(room):
	for line in lines:
		if line.begins_with(room):
			disable(line)
	
