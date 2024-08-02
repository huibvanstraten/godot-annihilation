class_name BossWalkComponent
extends Node

@export var lastWanderDirection: float = -1.0
@export var wanderSpeed: float = 100.0

@onready var groundContactChecker: RayCast2D = $"../../FlipMarker/GroundContactChecker"
@export var physicsComponent: PhysicsComponent = null
@export var flipComponent: FlipComponent = null
@export var characterBody: CharacterBody2D = null

func wander(delta: float):
	physicsComponent.speed = wanderSpeed
	physicsComponent.move(delta)
	
func stop_wander(delta: float):
	physicsComponent.direction.x = 0.0
	physicsComponent.stop(delta)
	
func change_direction():
	if groundContactChecker.is_colliding():
		lastWanderDirection = lastWanderDirection * -1
		physicsComponent.direction.x = lastWanderDirection
		flipComponent.flip()

func wander_start():
	lastWanderDirection = lastWanderDirection * -1
	physicsComponent.direction.x = lastWanderDirection
	flipComponent.flip()
