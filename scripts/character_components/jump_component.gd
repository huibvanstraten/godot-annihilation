class_name JumpComponent
extends Node

@export var jumpVelocity: float = -400.0
@export var wallJumpVelocityY: float = -300.0
@export var wallJumpVelocityX: float = 300.0
@export var characterBody: CharacterBody2D = null
@export var jumpGravity: float = 490

@onready var physicsComponent: PhysicsComponent =  $"../Physics"
@onready var flipComponent: FlipComponent =  $"../Flip"

var wallJump: bool = false
	
func jump():
	if wallJump:
		wall_jump()
	else:
		floor_jump()

func floor_jump():
	physicsComponent.velocityY = jumpVelocity

func wall_jump():
	var wall_side = characterBody.get_wall_normal()
	physicsComponent.direction.x = wall_side.x
	physicsComponent.velocityX = wallJumpVelocityX * wall_side.x
	physicsComponent.velocityY = wallJumpVelocityY
	flipComponent.flip()

func stop_jump(hitCeiling: bool):
	if Input.is_action_just_released("jump") and physicsComponent.velocityY < jumpVelocity / 2:
		physicsComponent.velocityY = jumpVelocity / 2
	elif hitCeiling:
		physicsComponent.velocityY = jumpVelocity / 6
		
