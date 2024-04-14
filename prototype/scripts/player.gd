extends CharacterBody2D

@export var move_Speed = 100
var player_direction: Vector2
func _physics_process(delta):
	player_direction = Input.get_vector("left", "right", "up", "down")
	velocity = player_direction * move_Speed
	if player_direction[0] > 0: #right
		$Untitled.flip_h = true
	elif player_direction[0] < 0: 
		$Untitled.flip_h = false
	move_and_slide()
