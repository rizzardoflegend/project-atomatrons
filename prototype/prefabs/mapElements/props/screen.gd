extends Node2D

var questions = 10
var correctAnswers = 0
var keypadNode = preload("res://prefabs/mapElements/props/keypad.tscn")
var instantiatedKeypad = keypadNode.instantiate()
var id = "screen"
var prefixes = {
	"n": -9,
	"μ": -6,
	"m": -3,
	"c": -2,
	"d": -1,
	"k": 3,
	"M": 6,
	"G": 9,
	"T": 12
}
var units = ["m", "g", "s"]
# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D/Label.text = "Approach the screen and the game shall begin."
	instantiatedKeypad.get_node("Sprite2D/LineEdit").max_length = 0
	instantiatedKeypad.get_node("Sprite2D/LineEdit").placeholder_text = "Include units"
	instantiatedKeypad.physics = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("escape"):
		exit_question($"../player")


func _on_area_2d_body_entered(body):
	if body.id == "player":
		start_question()
		body.canMove = false
	
func start_question():
	if questions == 0:
		questions = 10
		$"../player/Warning".text = "You have an accuracy rating of %s%" % correctAnswers/10
		exit_question($"../player")
		return 0
	var randomUnit = units.pick_random()
	var random = randi() % len(prefixes.keys())
	var randomPrefix = prefixes.keys()[random]
	var secondPrefix = prefixes.keys()[random-3]
	if random - 3 < 0:
		var num = random+1+randi()%3
		if num >= len(prefixes.keys()):
			num = len(prefixes.keys())-1
		secondPrefix = prefixes.keys()[num]
	var option1 = 1 + randi() % 50
	var questionType = randi() % 3
	if questionType == 0:
		$Sprite2D/Label.text = "Convert %s%s%s to %s%s" % [option1, randomPrefix, randomUnit, secondPrefix, randomUnit]
		instantiatedKeypad.answer = str(float(option1) * 10**(prefixes[randomPrefix] - prefixes[secondPrefix])) + secondPrefix + randomUnit
	elif questionType == 1:
		var randIndex = randi() % 2
		var firstUnit = "kg/m3"
		var secndUnit = "g/cm3"
		instantiatedKeypad.answer = float(option1) / 1000
		if randIndex == 0:
			firstUnit = "g/cm3"
			secndUnit = "kg/m3"
			instantiatedKeypad.answer = 1000 * option1
		$Sprite2D/Label.text = "Convert %s%s to %s" % [option1, firstUnit, secndUnit]
	elif questionType == 2:
		var randMass1 = str(100 + randi() % 1000) + ["g", "kg"].pick_random()
		var randVolume1 = str(100 + randi() % 1000) + ["cm3", "m3"].pick_random()
		var randMass2 = str(100 + randi() % 1000) + ["g", "kg"].pick_random()
		var randVolume2 = 100 + randi() % 1000 + ["cm3", "m3"].pick_random()
		$Sprite2D/Label.text = "There are 2 new liquids. Liquid 1 has a mass of %s and volume of %s, while liquid 2 has a mass of %s and volume of %s. Which liquid floats on the other?" % [randMass1, randVolume1, randMass2, randVolume2]
		
		if "kg" in randMass1:
			randMass1 = int(randMass1.replace("kg", "")) * 1000
		else:
			randMass1 = int(randMass1.replace("g", ""))
			
		if "cm3" in randVolume1:
			randVolume1 = int(randVolume1.replace("cm3", ""))
		else:
			randVolume1 = int(randVolume1.replace("m3", "")) * 1000000
			
		if "kg" in randMass2:
			randMass2 = int(randMass2.replace("kg", "")) * 1000
		else:
			randMass2 = int(randMass2.replace("g", ""))
		
		if "cm3" in randVolume2:
			randVolume2 = int(randVolume2.replace("cm3", ""))
		else:
			randVolume2 = int(randVolume2.replace("m3", "")) * 1000000
			
		if randMass1/randVolume1 > randMass2/randVolume2:
			instantiatedKeypad.answer = "2"
		else:
			instantiatedKeypad.answer = "1"
			
	instantiatedKeypad.position = Vector2.ZERO
	instantiatedKeypad.scale = Vector2(15,15)
	print(instantiatedKeypad.answer)
	instantiatedKeypad.visible = true
	instantiatedKeypad.z_index = 3
	instantiatedKeypad.get_node("Stats").text = $Sprite2D/Label.text 
	if instantiatedKeypad.get_parent() != $"../player":
		$"../player".add_child(instantiatedKeypad)
		
func next_question():
	if $"../player/Warning".text == "Correct!":
		correctAnswers += 1
	await get_tree().create_timer(1.0).timeout
	$Sprite2D/Label.text = "Next question.."
	questions -= 1
	start_question()

func exit_question(playerBody):
	playerBody.canMove = true
	instantiatedKeypad.visible = false
	
	
