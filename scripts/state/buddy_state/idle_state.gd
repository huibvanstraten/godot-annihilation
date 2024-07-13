class_name BuddyIdleState
extends State

@export var flyComponent: FlyComponent = null

var changeToWanderState: bool = false
var changeToFetchState: bool = false

var flyTimer: Timer

func initialize():
	flyTimer = Timer.new()
	flyTimer.one_shot = true
	add_child(flyTimer)

func enter():
	super()
	flyComponent.land()
	flyComponent.isFlying = false 
	flyComponent.isReturning = false
	flyTimer.connect("timeout", _on_timer_timeout)
	flyTimer.wait_time = choose([3.0, 5.0, 6.5])
	flyTimer.start()

func exit():
	super()
	flyTimer.stop()

func stateInput(_event: InputEvent) -> BuddyStateMachine.StateType:
	return BuddyStateMachine.StateType.Invalid
	
func stateMainProcess(_delta: float) -> BuddyStateMachine.StateType:
	if changeToWanderState:
		changeToWanderState = false
		return BuddyStateMachine.StateType.Wander
	elif changeToFetchState:
		changeToFetchState = false
		return BuddyStateMachine.StateType.Fetch
	return BuddyStateMachine.StateType.Invalid

func StatePhysicsProcess(_delta : float) -> BuddyStateMachine.StateType:
	return BuddyStateMachine.StateType.Invalid
	
func _on_timer_timeout():
	changeToWanderState = true

func _on_detection_area_area_entered(area):
	flyComponent.set_target_position((area as Area2D).global_position)
	changeToFetchState = true

func choose(array):
	array.shuffle()
	return array.front()
