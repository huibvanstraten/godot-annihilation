class_name LaserComponent
extends Node2D

@export var laserPosition: Marker2D = null
@export var physicsComponent: PhysicsComponent = null

var laserBeam: LaserBeam

var shouldEndLaserState: bool = false

func instantiate_laser():
	laserBeam = preload("res://scenes/entities/laser_beam.tscn").instantiate()
	laserBeam.direction = physicsComponent.facingDirection
	laserBeam.global_position = laserPosition.global_position
	get_tree().root.add_child.call_deferred(laserBeam)
	
	laserBeam.remove_laser.connect(_on_remove_laser)

func _on_remove_laser():
	laserBeam.queue_free()
	shouldEndLaserState = true
