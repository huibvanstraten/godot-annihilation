class_name BuddyStateMachine
extends StateMachine

enum StateType { Idle, Wander, Fetch, Return, Invalid }

func _process(delta):
	var nextState: StateType = currentState.stateMainProcess(delta)
	if (nextState != StateType.Invalid):
		changeState(get_child(nextState))

func _physics_process(delta):
	var nextState: StateType = currentState.StatePhysicsProcess(delta)
	if (nextState != StateType.Invalid):
		changeState(get_child(nextState))
