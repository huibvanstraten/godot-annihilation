class_name EnemyStateMachine
extends StateMachine

enum StateType { Idle, Die, Walk, Hit, Attack, Invalid }

func _process(delta):
	var nextState: StateType = currentState.stateMainProcess(delta)
	if (nextState != StateType.Invalid):
		changeState(get_child(nextState))

func _physics_process(delta):
	var nextState: StateType = currentState.StatePhysicsProcess(delta)
	if (nextState != StateType.Invalid):
		changeState(get_child(nextState))

func can_move() -> bool:
	return currentState.can_move
