class_name BossWalkComponent
extends Node

@export var wanderSpeed: float = 100.0

@onready var groundContactChecker: RayCast2D = $"../../FlipMarker/GroundContactChecker"
@export var physicsComponent: PhysicsComponent = null
@export var flipComponent: FlipComponent = null
@export var positionComponent: PositionComponent = null
@export var characterBody: CharacterBody2D = null

func walkTo(positionToTravel: Vector2):
	physicsComponent.move_to_target(positionToTravel, wanderSpeed)
	
func stop_wander(delta: float):
	#physicsComponent.direction.x = 0.0
	physicsComponent.stop(delta)
	
func change_direction():
	if groundContactChecker.is_colliding():
		physicsComponent.direction.x = physicsComponent.facingDirection * -1
		flipComponent.flip()

func select_walking_position():
	positionComponent.select_position()
