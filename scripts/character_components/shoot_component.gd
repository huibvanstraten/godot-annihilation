class_name ShootComponent
extends Node

@export var gunMarker: Marker2D = null

@onready var shootBufferTimer: Timer = $ShootBufferTimer
@onready var physicsComponent: PhysicsComponent =  $"../Physics"

func shoot():
	if shootBufferTimer.time_left > 0: pass
	
	var bullet = preload("res://scenes/bullet.tscn").instantiate()
	bullet.spawnPosition = gunMarker.position
	bullet.direction = physicsComponent.facingDirection
	get_parent().add_child(bullet)
	shootBufferTimer.start()
