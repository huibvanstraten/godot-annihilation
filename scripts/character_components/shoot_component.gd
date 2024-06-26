class_name ShootComponent
extends Node

@export var gunMarker: Marker2D = null

@onready var physicsComponent: PhysicsComponent =  $"../Physics"

func shoot():
	var bullet = preload("res://scenes/bullet.tscn").instantiate()
	bullet.spawnPosition = gunMarker.position
	bullet.direction = physicsComponent.facingDirection
	get_parent().add_child(bullet)

func shooting_animation(stateName: String) -> String:
	var animationToPlay: String
	
	if stateName == "idle":
		animationToPlay = "idle_shoot"
	elif stateName == "run":
		animationToPlay = "run_shoot"
	elif stateName == "jump": 
		animationToPlay = "jump_shoot"
	elif stateName == "fall": 
		animationToPlay = "jump_shoot"
	else:
		push_error("This state has no shoot ability")

	return animationToPlay
