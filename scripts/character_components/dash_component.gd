class_name DashComponent
extends Node2D

@export var positionComponent: PositionComponent = null
@export var physicsComponent: PhysicsComponent = null

@export var dashSpeed: float = 600

func dash_position():
	positionComponent.select_position()

func dash_to(targetPosition: Vector2):
	physicsComponent.move_to_target(targetPosition, dashSpeed)
