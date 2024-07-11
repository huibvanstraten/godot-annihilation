extends Node2D

var player: CharacterBody2D = null
var last_spawn_point = null
var player_node_path: NodePath

func set_spawn_point(spawn_point_name):
	last_spawn_point = spawn_point_name
	
func spawn_player(spawn_position, pixelformat):
	if player == null:
		if pixelformat:
			player = preload("res://scenes/entities/player64.tscn").instantiate()
		else:
			player = preload("res://scenes/entities/player.tscn").instantiate()
		var level = LevelManager.get_current_level()
		level.add_child(player)
	else:
		var health = player.find_child("Health") as HealthComponent
		health.reset_health()
		var physics = player.find_child("Physics") as PhysicsComponent
		physics.reset_velocity()
	
	if last_spawn_point == null:
		player.position = spawn_position
	else:
		player.position = last_spawn_point