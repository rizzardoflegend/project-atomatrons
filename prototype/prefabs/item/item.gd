extends TextureButton

# Called when the node enters the scene tree for the first time.
@export var itemType = "BERRIES"

func _ready():
	pass # Replace with function body.

"""
Standard Food Stats
var carbs = 100 
var proteins = 80
var fats = 60
var vitC = 30
var vitD = 15
var calcium = 20
var iron = 20
"""
func _on_pressed():
	print(itemType)
	$"../player/Inventory".addItem(itemType)
	PlayerInfo.player_speed_modifier = 1.5
	if itemType == "BERRIES":
		PlayerInfo.carbs += 10
		PlayerInfo.vitC += 15
	elif itemType == "SPINACH":
		PlayerInfo.calcium += 5
		PlayerInfo.iron += 10
	elif itemType == "TOMATO":
		pass
	elif itemType == "PETRI":
		$"../player/Inventory".addItem(itemType)
	visible = false
	PlayerInfo.player_speed_modifier = 1
	queue_free()

func _on_area_2d_body_entered(body):
	if body.id == "player":
		print('its the end of you')
	else:
		print("womp womp")
		