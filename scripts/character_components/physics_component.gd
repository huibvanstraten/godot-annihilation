class_name PhysicsComponent
extends Node

@export var velocityX: float
@export var velocityY: float
@export var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var acceleration: float = 3300.0
@export var friction: float = 3000.0
@export var airFriction: float = 1000.0
@export var knockbackVelocity: Vector2 = Vector2(100, 0)
@export var knockbackDirection: int 
@export var speed = 600.0
@export var airSpeed = 300.0
@export var direction: Vector2 = Vector2.RIGHT

@export var collisionRotation: float = 0
@export var collisionSizeY: float = 1

var facingDirection: int = 1
var defaultGravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

func reset_gravity():
	gravity = defaultGravity

func set_velocity(delta: float):
	velocityY += gravity * delta

func reset_velocity():
	velocityY = 0

func set_knockback_direction(knockback_direction: int):
	knockbackDirection = knockback_direction

func knock_back(): 
	velocityX = knockbackVelocity.x * knockbackDirection
	
func move(delta, inputAxis: float = direction.x):
	speed = speed
	direction.x = inputAxis
	velocityX = direction.x * speed
	velocityX = move_toward(velocityX, direction.x * speed, acceleration * delta)

func move_in_air(delta, inputAxis):
	velocityX = velocityX * 0.9
	direction.x = inputAxis
	velocityX = move_toward(velocityX, direction.x * airSpeed, acceleration * delta)

func move_to_target(targetPosition: Vector2, delta, attackSpeed: float):
	speed = attackSpeed
	direction = targetPosition
	move(delta)

func stop(delta: float):
	direction.x = 0.0
	velocityX = move_toward(velocityX, 0, friction * delta)

func air_resistance(delta: float):
	velocityX = move_toward(velocityX, 0, airFriction * delta)
