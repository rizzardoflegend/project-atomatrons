extends Node2D

@export var text = ""
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	$"../player/Warning".text = text
	await get_tree().create_timer(1.0).timeout
	$"../player/Warning".text = " "

func _on_area_2d_body_exited(body):
	$"../player/Warning".text = " "
