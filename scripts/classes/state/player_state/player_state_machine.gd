class_name PlayerStateMachine
extends StateMachine

enum StateType { Idle, Run, Jump, Fall, Attack, Hit, Die, Wall, Shoot, Crouch, Ledge, Invalid }

var stateTypeDict = {
	"Idle": StateType.Idle,
	"Run": StateType.Run,
	"Jump": StateType.Jump,
	"Fall": StateType.Fall,
	"Attack": StateType.Attack,
	"Hit": StateType.Hit,
	"Die": StateType.Die,
	"Wall": StateType.Wall,
	"shoot": StateType.Shoot,
	"crouch": StateType.Crouch,
	"ledge": StateType.Ledge,
	"Invalid": StateType.Invalid
}

func get_enum_value(enumName: String):
	if stateTypeDict.has(enumName):
		return stateTypeDict[enumName]
	else:
		return StateType.Invalid

func _process(delta):
	var nextState: StateType = currentState.stateMainProcess(delta)
	if (nextState != StateType.Invalid):
		changeState(get_child(nextState))

func _physics_process(delta):
	var nextState: StateType = currentState.StatePhysicsProcess(delta)
	if (nextState != StateType.Invalid):
		changeState(get_child(nextState))

func can_move() -> bool:
	return currentState.canMove
