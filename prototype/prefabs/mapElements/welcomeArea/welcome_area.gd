extends Node2D

@export var nameOfArea = ""
const id = "welcomeArea"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_body_entered(body):
	if body.id == "player":
		if nameOfArea:
			$"../../player/Warning".text = nameOfArea
		else:
			print("ruh roh")

func _on_area_2d_body_exited(body):
	if body.id == "player":
		$"../../player/Warning".text = ""

