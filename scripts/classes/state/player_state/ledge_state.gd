class_name LedgeState
extends State

@onready var physicsComponent: PhysicsComponent = $"../../Components/Physics"
@onready var ledgeComponent: LedgeComponent = $"../../Components/Ledge"

var ledgeAnimationFinished: bool = false

func enter():
	super()
	print("entering ledge")
	physicsComponent.velocityY = 0
	physicsComponent.gravity = 0
	
func exit():
	super()
	physicsComponent.reset_gravity()

func stateInput(_event: InputEvent) -> PlayerStateMachine.StateType:
	return PlayerStateMachine.StateType.Invalid
	
func stateMainProcess(_delta: float) -> PlayerStateMachine.StateType:
	return PlayerStateMachine.StateType.Invalid

func StatePhysicsProcess(_delta : float) -> PlayerStateMachine.StateType:
	var letGo: bool = Input.is_action_just_released("jump")
	
	if entityHit:
		entityHit = false
		return PlayerStateMachine.StateType.Hit
	
	elif healthDepleted:
		healthDepleted = false
		return PlayerStateMachine.StateType.Die
		 
	elif letGo:
		return PlayerStateMachine.StateType.Fall
		
	elif ledgeAnimationFinished:
		ledgeAnimationFinished = false
		ledgeComponent.climbLedge()
		return PlayerStateMachine.StateType.Idle
	
	return PlayerStateMachine.StateType.Invalid

func _on_animation_player_animation_finished(animName):
	if animName == "ledge":
		ledgeAnimationFinished = true
