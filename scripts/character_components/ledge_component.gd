class_name LedgeComponent
extends Node

@export var entity: CharacterBody2D = null
@export var sideHitMargin = 2.0

@onready var physicsComponent: PhysicsComponent =  $"../Physics"
@onready var ledgeDetector: RayCast2D = $"../../FlipMarker/LedgeDetector"
@onready var wallDetector: RayCast2D = $"../../FlipMarker/WallDetector"

var ledgePosition: Vector2 = Vector2.ZERO

func canClimbLedge() -> bool:
	var canClimb: bool = false

	if !ledgeDetector.is_colliding() and wallDetector.is_colliding() and not entity.is_on_floor():
		var ledge = wallDetector.get_collider()

		if ledge is TileMap or CollisionShape2D:
			canClimb = true

	return canClimb

func climbLedge(facingRight: bool):
	physicsComponent.velocityY = -220
