class_name FlyComponent
extends Node

signal reached_destination(hasReturned: bool)

@export var buddy: Node2D = null

@export var defaultSpeed: float = 200
@export var amplitude: float = 20
@export var frequency: float = 3

var isFlying: bool = false:
	set(value):
		buddy.isFlying = value

var isReturning: bool = false

var timePassed: float
var speed: float = 0

func fly(delta):
	timePassed += delta
	
	var direction = (buddy.targetPosition - buddy.position).normalized()
	var facingDirection = 1
	if sign(direction.x) != 0: 
		facingDirection = sign(direction.x) 
	buddy.scale.x = facingDirection
	buddy.position += direction * speed * delta
	buddy.position.y += amplitude * sin(frequency * timePassed / 5)
	
	if buddy.position.distance_to(buddy.targetPosition) < 10:
		if isReturning:
			emit_signal("reached_destination", true)
		else:
			emit_signal("reached_destination", false)
	
func set_random_target_position():
	var targetPositionX = randf_range(-300, 300)
	var targetPositionY = randf_range(-450, 0)
	
	buddy.targetPosition = buddy.position + Vector2(targetPositionX, targetPositionY )

func returnToPlayer():
	buddy.targetPosition = buddy.spawnMarker.global_position

func land():
	buddy.position = buddy.spawnMarker.global_position
	
func set_target_position(target: Vector2):
	buddy.targetPosition = target
	
