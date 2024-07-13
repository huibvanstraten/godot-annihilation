class_name BuddyFetchState
extends State

@export var flyComponent: FlyComponent = null

var changeToReturnState: bool = false

func initialize():
	flyComponent.connect("reached_destination", _on_reached_destination)

func enter():
	super()
	flyComponent.isFlying = true 
	flyComponent.speed = flyComponent.defaultSpeed * 1.5

func exit():
	super()

func stateInput(_event: InputEvent) -> BuddyStateMachine.StateType:
	return BuddyStateMachine.StateType.Invalid
	
func stateMainProcess(delta: float) -> BuddyStateMachine.StateType:
	
	flyComponent.fly(delta)
	
	if changeToReturnState:
		changeToReturnState = false
		flyComponent.isReturning = true
		return BuddyStateMachine.StateType.Return
	return BuddyStateMachine.StateType.Invalid

func StatePhysicsProcess(_delta : float) -> BuddyStateMachine.StateType:
	return BuddyStateMachine.StateType.Invalid

func _on_reached_destination(hasReturned: bool):
	if not hasReturned:
		changeToReturnState = true
