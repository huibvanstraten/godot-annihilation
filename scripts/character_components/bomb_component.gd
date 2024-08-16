class_name BombComponent
extends Node

@export var bombMarker: Marker2D = null

@onready var shootBufferTimer: Timer = $ShootBufferTimer
@onready var physicsComponent: PhysicsComponent = $"../Physics"

func shoot() -> bool:
	if shootBufferTimer.time_left > 0: return false
	else:
		var bomb = preload("res://scenes/entities/bomb.tscn").instantiate()

		bomb.global_position = bombMarker.global_position
		get_tree().root.add_child(bomb)
		shootBufferTimer.start()
		return true
