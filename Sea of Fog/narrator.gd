extends AudioStreamPlayer

var completed = []
var line_files = [
	"intro",
	"entrance",
]
var lines = [
	"Hours have passed since the battle's end. I've wandered aimlessly, calling out for my squad, but all I hear is silence. Unable to scale the treacherous mountainsides, I'm left with no choice but to delve deeper into this Sea of Fog.",
	"A tunnel? It's ancient, but... perhaps it's a path to escape.",
	"After countless trials, I stumble upon a stairway. Without hesitation, I ascend, hoping to finally reach the mountain's summit. And then, as I gaze down into the depths of the valley, the undeniable truth reveals itself... This world is not the one I left behind. It's a different one, shrouded in truly endless fog and crowned with alien mountains. Yet, instead of despair, a sense of contentment washes over me. Accepting my fate, I release the futile pursuit of my past. Once more, I choose to press forward, delving deeper into the unknown, eager to uncover its mysteries and shape my own destiny. For I am, and always will be, a wanderer above the sea of fog...",
	"As I step into the dimly lit chamber, a cracked mirror catches my eye. A pile of rubble occupies one corner, two weathered barrels rest in another, and near the entrance, a rusted iron grate lies embedded in the floor.",
	"Among the debris, I uncover a hidden lever. As I pull it, a distant rumble echoes through the chamber.",
	"The distorted images staring back at me offer no answers.",
	"The barrels sit empty. Their contents are long decayed.",
	"Despite my efforts, I find no means to open the iron grate.",
	"In the fog-shrouded courtyard, an ancient statue loom ominously. A weathered fountain stands in the center, while along one wall, a mural tells the tales of a forgotten civilization.",
	"In the fountain, atop the central pedestal, I find a loose crystal orb. I decide to take it with me.",
	"The statue, though imposing, offers no clues for my journey.",
	"The faded mural yields no answers, its meaning lost to time.",
	"As I step into the small room, I notice five discs embedded in the wall, each adorned with symbols. Nearby, mysterious writing graces the floor...",
	"As the discs align, the ground trembles, accompanied by a distant rumble echoing from outside.",
	"Upon the wall, the glyphs align, to reveal the way, by design.",
	"It won't budge...",
	"In a secluded glade, I stumble upon an altar. A small chest rests at its center, flanked by stone plates adorned with symbols. Beside them stands an obelisk, its inscription catching my eye.",
	"The chest swings open, unveiling a mysterious black gem. I quickly take hold of it.",
	"In nature's dance, I play my part. Each season brings its own unique art. To unlock the treasure, heed this decree: Step on the stones in order to see.",
	"Winter",
	"Spring",
	"Summer",
	"Autumn",
	"As I step into the chamber, the air feels heavy with the weight of time. In the center of the room, a bare pedestal stands beneath a shaft of weak sunlight, casting a gentle glow. In front of it, a small stone plate, adorned with the symbol of time. A canal runs through the middle of the room, flowing past the pedestal like a river.",
	"Upon closer examination, I discover a gemstone shape carved into the top of the pedestal.",
	"I place the black gem into the pedestal, then hear a faint clicking sound emanating from under the stone plate.",
	"I step on the plate, but to my surprise, it remains unmoved. It seems there are hidden mechanics at play preventing its activation.",
	"I step on the plate, feeling it slowly begin to descend beneath my weight.",
	"Time stretches endlessly as the plate slowly descends, each second feeling like an eternity. At last, it comes to a stop, and in the next instant, the pedestal begins to rise, sealing the gap in the ceiling. The air fills with the sound of heavy rocks shifting outside.",
]

var line_resources = []

func _ready():
	for line in line_files:
		line_resources.append(load("res://" + line + ".mp3"))

func say(line, once = true):
	if completed.has(line):
		return
	$"%NarrationContainer".show()
	$"%Narration".text = lines[line]
	stream = line_resources[line]
	.play()
	if once:
		completed.append(line)
	