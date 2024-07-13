class_name BuddyReturnState
extends State

@export var flyComponent: FlyComponent = null

var changeToIdleState: bool = false

func initialize():
	flyComponent.connect("reached_destination", _on_reached_destination)

func enter():
	super()
	flyComponent.isFlying = true 

func exit():
	super()

func stateInput(_event: InputEvent) -> BuddyStateMachine.StateType:
	return BuddyStateMachine.StateType.Invalid
	
func stateMainProcess(delta: float) -> BuddyStateMachine.StateType:
	
	flyComponent.returnToPlayer()
	flyComponent.fly(delta)
	
	if changeToIdleState:
		changeToIdleState = false
		return BuddyStateMachine.StateType.Idle
		
	return BuddyStateMachine.StateType.Invalid

func StatePhysicsProcess(_delta : float) -> BuddyStateMachine.StateType:
	return BuddyStateMachine.StateType.Invalid

func _on_reached_destination(hasReturned: bool):
	if hasReturned:
		changeToIdleState = true
