class_name BossJumpComponent
extends Node2D

@export var physicsComponent: PhysicsComponent = null
@export var positionComponent: PositionComponent = null

@export var timeToJumpPeak: float = .4
@export var jumpHeight: float = 128

var gravity: float
var jumpSpeed: float

func _ready():
	gravity = (2 * jumpHeight) / pow(timeToJumpPeak, 2)
	jumpSpeed = gravity * timeToJumpPeak

func get_to_target():
	physicsComponent.velocityX = 0.0
	physicsComponent.velocityY = 600

func jump_to(positionTo: Vector2):
	physicsComponent.direction = sign(positionTo)
	physicsComponent.velocityX = 400.0 * sign(positionTo.x)
	physicsComponent.velocityY = -jumpSpeed
