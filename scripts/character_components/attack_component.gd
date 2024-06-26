class_name AttackComponent
extends Node

@export var damage: float = 10
@export var speed: float = 250.0
@export var jumpSpeed: float = 500.0
@export var jumpheight: float = 50.0

@onready var detectionArea: Area2D = $"../../FlipMarker/DetectionArea"
@onready var physicsComponent: PhysicsComponent = $"../Physics"

var playerInRange: bool = false
var player: CharacterBody2D = null

func attack(targetPosition: Vector2, delta):
	physicsComponent.move_to_target(targetPosition, delta, speed)

func get_target_position() -> Vector2:
	return Vector2(player.position.x, player.position.y)

func _on_detection_area_body_entered(body):
	playerInRange = true
	player = body as CharacterBody2D

func _on_detection_area_body_exited(_body):
	playerInRange = false
	player = null
