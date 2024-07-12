class_name FlyComponent
extends Node

signal reached_destination(hasReturned: bool)

@export var buddy: Node2D = null

@export var defaultSpeed: float = 100
@export var amplitude: float = 20
@export var frequency: float = 3

var isFlying: bool = false:
	set(value):
		buddy.isFlying = value

var timePassed: float

var speed: float = 0

func _ready(): 
	buddy.startPosition = buddy.position

func fly(delta):
	timePassed += delta
	
	var direction = (buddy.targetPosition - buddy.position).normalized()
	buddy.position += direction * speed * delta
	#buddy.position.y += amplitude * sin(frequency * timePassed)
	
	if buddy.position.distance_to(buddy.targetPosition) < 10:
		if buddy.targetPosition == buddy.startPosition:
			emit_signal("reached_destination", true)
		else:
			emit_signal("reached_destination", false)
	
func set_random_target_position():
	var targetPositionX = randf_range(-100, 150)
	var targetPositionY = randf_range(-150, 150)
	
	buddy.targetPosition = buddy.position + Vector2(targetPositionX, targetPositionY )

func returnToPlayer():
	buddy.targetPosition = buddy.startPosition
	
func set_target_position(target: Vector2):
	buddy.targetPosition = target
	
