class_name ShootComponent
extends Node

@export var gunMarker: Marker2D = null

@onready var shootBufferTimer: Timer = $ShootBufferTimer
@onready var physicsComponent: PhysicsComponent =  $"../Physics"

func shoot() -> bool:
	if shootBufferTimer.time_left > 0: return false
	else:
		var bullet = preload("res://scenes/entities/bullet.tscn").instantiate()

		bullet.global_position = gunMarker.global_position
		bullet.spawnPosition = gunMarker.global_position
		bullet.direction = physicsComponent.facingDirection
		get_tree().root.add_child(bullet)
		shootBufferTimer.start()
		return true
