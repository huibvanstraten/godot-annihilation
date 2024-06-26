class_name LedgeComponent
extends Node

@export var entity: CharacterBody2D = null
@export var sideHitMargin = 2.0

@onready var ledgeDetector: RayCast2D = $"../../FlipMarker/LedgeDetector"
@onready var wallDetector: RayCast2D = $"../../FlipMarker/WallDetector"

var ledgePosition: Vector2 = Vector2.ZERO

func canClimbLedge(facingRight: bool) -> bool:
	var canClimb: bool = false
	
	if !ledgeDetector.is_colliding() and wallDetector.is_colliding() and not entity.is_on_floor():		
		var ledge = wallDetector.get_collider()

		if ledge is TileMap:
			if facingRight:
				ledgePosition = Vector2(ledgeDetector.global_position.x + 130, ledgeDetector.global_position.y +35)
				print(ledgePosition)
				print(entity.global_position)	
			else: 
				ledgePosition = Vector2(ledgeDetector.global_position.x + 80, ledgeDetector.global_position.y + 35)
			canClimb = true
		#if !facingRight:
			#if entity.move_and_collide(Vector2(-sideHitMargin, 0)):
				#print("can climb")
				#canClimb = true
		#else:
			#if entity.move_and_collide(Vector2(sideHitMargin, 0)):
				#canClimb = true
				#print("can climb")

	return canClimb

func climbLedge():
	entity.position = ledgePosition
