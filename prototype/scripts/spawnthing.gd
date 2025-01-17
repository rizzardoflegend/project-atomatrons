extends Node2D

var nitrogen_scene = preload("res://prefabs/nitrogen/field/nitrogen_field.tscn")
var spawn_timer = Timer.new()
var despawn_timer = Timer.new()

var player
var spawn_radius
var min_spawn_distance
var max_spawn_distance

func _ready():
	player = get_node("/root/TestField/player")
	spawn_radius = player.field_of_view
	min_spawn_distance = spawn_radius / 2
	max_spawn_distance = spawn_radius

	spawn_timer.connect("timeout", self, "_on_spawn_timer_timeout")
	despawn_timer.connect("timeout", self, "_on_despawn_timer_timeout")
	
	add_child(spawn_timer)
	add_child(despawn_timer)
	
	start_spawn_timer()

func start_spawn_timer():
	var spawn_interval = randf_range(2, 5)
	spawn_timer.set_wait_time(spawn_interval)
	spawn_timer.start()

func _on_spawn_timer_timeout():
	var spawn_position = calculate_spawn_position()
	var nitrogen_instance = nitrogen_scene.instance()
	nitrogen_instance.position = spawn_position
	add_child(nitrogen_instance)

	var despawn_time = randf_range(10, 15)
	despawn_timer.set_wait_time(despawn_time)
	despawn_timer.start()
	
	start_spawn_timer()

func _on_despawn_timer_timeout():
	var nitrogen_instances = get_tree().get_nodes_in_group("nitrogen")
	if nitrogen_instances.size() > 0:
		var nitrogen_to_despawn = nitrogen_instances[0]
		nitrogen_to_despawn.queue_free()

func calculate_spawn_position():
	var spawn_angle = randf_range(0, 2 * PI)
	var spawn_distance = randf_range(min_spawn_distance, max_spawn_distance)
	var spawn_offset = Vector2(cos(spawn_angle), sin(spawn_angle)) * spawn_distance
	return player.global_position + spawn_offset
