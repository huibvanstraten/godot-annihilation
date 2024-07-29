class_name State
extends Node

@export var characterBody: CharacterBody2D = null
@export var nodeAnimationSprite: AnimatedSprite2D = null
@export var nodeAnimation: AnimationPlayer = null
@export var collisionshape: CollisionShape2D = null

@export var shootComponent: ShootComponent = null

@export var stateName: String
@export var animationName: String
@export var sfxName: String

# TODO: move this (jump
@export var canMove: bool = true

var entityHit: bool = false
var healthDepleted: bool = false
var isParalyzed: bool = false

# TODO: move this (jump
var playerInRange: bool = false

# TODO: move this (jump
var jumpBufferTime: float = 8
var jumpBufferCounter: float = 0
var coyoteTime: float = 8
var coyoteCounter: float = 0

func initialize():
	EventManager.connect("health_depleted", _on_health_depleted)
	EventManager.connect("entity_hit", _on_entity_hit)
	EventManager.paralyze.connect(_on_paralyze)

func enter():
	nodeAnimation.play(animationName)

func exit():
	pass

func _on_health_depleted(entity: CharacterBody2D):
	if characterBody != entity:
		healthDepleted = false
	else:
		healthDepleted = check_state_type(entity)
		
func _on_entity_hit(entity: CharacterBody2D):
	if characterBody != entity:
		entityHit = false
	else:
		entityHit = check_state_type(entity)

func _on_paralyze(entity: CharacterBody2D):
	if characterBody != entity:
		isParalyzed = false
	else:
		isParalyzed = check_state_type(entity)
	
func check_state_type(entity: CharacterBody2D) -> bool:
	var stateMachine = entity.find_child("StateMachine") as StateMachine
	return stateMachine.currentState.stateName == stateName

func get_previous_state_type(entity: CharacterBody2D) -> String:
	var stateMachine = entity.find_child("StateMachine") as StateMachine
	return stateMachine.previousState.stateName

# TODO: move this (jump
func jumpBuffer():
	if Input.is_action_just_pressed("jump"):
		jumpBufferCounter = jumpBufferTime
	if jumpBufferCounter > 0:
		jumpBufferCounter -= 1
