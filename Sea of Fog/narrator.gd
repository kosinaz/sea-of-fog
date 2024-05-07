extends AudioStreamPlayer

var completed = []
var disabled = []

var lines = {
	"intro": "Hours have passed since the battle's end. I've wandered aimlessly, calling out for my squad, but all I hear is silence. Unable to scale the treacherous mountainsides, I'm left with no choice but to delve deeper into this Sea of Fog.",
	"ending": "After countless trials, I stumble upon a stairway. Without hesitation, I ascend, hoping to finally reach the mountain's summit. And then, as I gaze down into the depths of the valley, the undeniable truth reveals itself... This world is not the one I left behind. It's a different one, shrouded in truly endless fog and crowned with alien mountains. Yet, instead of despair, a sense of contentment washes over me. Accepting my fate, I release the futile pursuit of my past. Once more, I choose to press forward, delving deeper into the unknown, eager to uncover its mysteries and shape my own destiny. For I am, and always will be, a wanderer above the sea of fog...",
	"full ending": "After countless trials, I stumble upon a stairway. Without hesitation, I ascend, hoping to finally reach the mountain's summit. And then, as I gaze down into the depths of the valley, the undeniable truth reveals itself... This world is not the one I left behind. It's a different one, shrouded in truly endless fog and crowned with alien mountains. Yet, instead of despair, a sense of contentment washes over me. Accepting my fate, I release the futile pursuit of my past. With the Cane of Guidance in hand, I find solace in the clarity it brings, illuminating the path ahead in the midst of uncertainty. Once more, I choose to press forward, delving deeper into the unknown, eager to uncover its mysteries and shape my own destiny. For I am, and always will be, a wanderer above the sea of fog...",
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
	"square intro": "Before me, a peculiar square cut into the mountain's side. The entire square is made up of moving platforms, rising and falling unpredictably. A tunnel entrance awaits on the other side, promising unknown adventures.",
	"square ending": "The moving platforms, once a daunting obstacle, are now conquered. I stand before the entrance of the tunnel and  despite the darkness that looms ahead, I'm drawn to the unknown like a moth to a flame.",
	"maze intro": "As I step into the chamber, darkness envelops me like a thick cloak. There's no discernible path ahead, only the faint glimmer of light in the distance.",
	"maze ending": "Stepping into the light, a hidden pressure plate beneath my foot begins to shift, accompanied by the distant sound of moving rocks and the gentle flow of water. Another bridge, no doubt, ascends from the river below.",
	"maze riddle": "\"In the depths of darkness, where shadows thrive, find your own light to help you survive.\"",
	"clock tower intro": "I step into the remnants of a once-grand clock tower. Across the hall, the broken clock, frozen in time. In front of it, discarded gears and a broken pendulum lie strewn across the ground, next to a pile of rocks. Beside the clock, a riddle etched onto the wall beckons me to unravel its message.",
	"clock tower ending": "After numerous attempts, I find myself setting the clock once more, almost resigned to the repetitive task. Suddenly, a subtle shift occurs, the hands begin to move on their own accord. And then, a rusted key falls to the ground from the hidden compartment of the clock. I quickly take it.",
	"clock tower clock": "I set the time on the clock, yet nothing stirs.",
	"clock tower riddle": "\"Time's hands once moved with grace. Now they linger in a frozen space. To break the spell and set time free. Turn the hands repeatedly, one, two, or three. As seconds pass and hours fly, unlock the secrets that beneath them lie.\"",
	"clock tower rocks": "The pile of rocks seem insignificant, just ordinary stones strewn about the ruins.",
	"clock tower pendulum": "While the pendulum may look significant, it's clear that it's no longer functional and serves no purpose in fixing the clock.",
	"clock tower gear": "At first glance, this rusty gear seems like a crucial component of the clock tower mechanism. However, upon closer inspection, it appears to be too corroded to be of any use.",
	"invention hall intro": "Entering the vast hall, my gaze is drawn to three towering automatons standing in stoic vigilance. Across from them stands a peculiar steam engine, its purpose uncertain. Scattered about the floor are various contraptions and gears, while at the far end looms an imposing door.",
	"invention hall ending": "Finally, the door opens.",
	"invention hall door": "This door is different. It requires a key. One I must seek out.",
	"invention hall door open": "I insert the key, and with a satisfying click, the door swings open.",
	"invention hall riddle": "\"Strength, speed, cunning, three trials to pass, to reveal my hidden path.\"",
	"invention hall strength": "\"I stand tall, guardian of strength, prove your worth, enthrall my arm at length.\" As I try to move the arm, it remains steadfast, refusing to yield to my strength.",
	"invention hall strength ending": "I secure the wire to the automaton's arm and activate the engine. As the arm complies, a mechanical hum emanates from the direction of the door.",
	"invention hall speed": "\"I am the guardian of speed. In my palm, the marble you must heed.\" As I attempt to snatch the marble from the motionless palm, the automaton swiftly retracts it, leaving me empty-handed.",
	"invention hall speed ending": "The magnet does its job. With the marble in hand, I hear a distant hum of machinery emanating from the door.",
	"invention hall cunning": "\"I am the guardian of cunning and sly. Unlock my mind to pass me by.\" I'm lost. There's nothing on this automaton to guide me.",
	"invention hall cunning ending": "I press the button, and immediately, I hear mechanical noises emanating from the direction of the door.",
	"invention hall wire": "I notice a wire on the floor beside the engine. A sudden idea strikes, and I swiftly grab it, intending to use it to my advantage by attaching it to the automaton.",
	"invention hall magnet": "I discover a small cabinet on the wall containing a sturdy magnet. It should aid in slowing down those swiftly moving steel appendages.",
	"invention hall book": "I discover a workbook lying on the floor, containing detailed blueprints of the automatons. It highlights a hidden button within the head that can deactivate the machine.",
	"flower gate intro": "\"In the sea of fog, twelve golden flowers lie. Collect them all, and the Gate of Exploration will comply.\"",
	"flower gate ending": "As I place each flower in front of the gate, it yields with a creek, sinking into the earth below.",
	"flower gate closed": "I can't budge it.",
	"flower gate first": "A golden flower. I must take it.",
	"flower gate second": "Another golden flower.",
	"reflection field intro": "Entering the expansive garden, I'm met with a curious sight. Rows of columns punctuate the landscape, and at the heart of it all, a statue, oddly resembling myself, grips a cane in its hand. Across from it lies a mirrored scene, with columns shifted and an empty pedestal.",
	"reflection field ending": "As I stand on the pedestal, a soft click emanates from below, and a hidden compartment opens. A cane, identical to the one clutched by my statue, springs into my hand. Upon closer examination, I notice the inscription: 'Cane of Guidance.' At its apex, a mysterious gem catches my eye, offering a view of the world around me like a living map in this Sea of Fog. With it, I know I'll never lose my way again.",
	"reflection field statue": "As I approach the statue, a shiver runs down my spine. It's an eerie likeness of myself, down to the smallest detail, but holding a cane that I've never seen before.",
	"reflection field column moves": "Ah, as expected, these columns can be shifted.",
	"reflection field column stuck": "This column won't budge.",
	"reflection field pedestal": "Standing on the pedestal yields no result. It seems there's still something missing from the picture.",
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
	
