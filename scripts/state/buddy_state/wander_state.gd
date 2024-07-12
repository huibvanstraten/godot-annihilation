class_name BuddyWanderState
extends State

@export var flyComponent: FlyComponent = null

var changeToReturnState: bool = false
var changeToFetchState: bool = false

func initialize():
	flyComponent.connect("reached_destination", _on_reached_destination)

func enter():
	super()
	flyComponent.isFlying = true 
	flyComponent.speed = flyComponent.defaultSpeed
	flyComponent.set_random_target_position()

func exit():
	super()

func stateInput(_event: InputEvent) -> BuddyStateMachine.StateType:
	return BuddyStateMachine.StateType.Invalid
	
func stateMainProcess(delta: float) -> BuddyStateMachine.StateType:
	
	flyComponent.fly(delta)
	
	if changeToReturnState:
		changeToReturnState = false
		return BuddyStateMachine.StateType.Return
	elif changeToFetchState:
		changeToFetchState = false
		return BuddyStateMachine.StateType.Fetch
	return BuddyStateMachine.StateType.Invalid

func StatePhysicsProcess(_delta : float) -> BuddyStateMachine.StateType:
	return BuddyStateMachine.StateType.Invalid

func _on_reached_destination(hasReturned: bool):
	if not hasReturned:
		changeToReturnState = true
	
func _on_detection_area_area_entered(area):
	flyComponent.set_target_position((area as Area2D).global_position)
	changeToFetchState = true

func choose(array):
	array.shuffle()
	return array.front()
