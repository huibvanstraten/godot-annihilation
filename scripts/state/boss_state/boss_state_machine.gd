class_name BossStateMachine
extends StateMachine

enum BossStateType { Idle, Walk, Jump, Laser, Mushroom, Attack, Dash, Hit, Die, Invalid }

const STATE_PROBABILITIES = {
	BossStateType.Walk: 0.7,
	BossStateType.Mushroom : 0.3 
}

const STATE_DICTIONARY = {
	"Idle": BossStateType.Idle,
	"walk": BossStateType.Walk,
	"jump": BossStateType.Jump,
	"laser": BossStateType.Laser,
	"mushroom": BossStateType.Mushroom,
	"attack": BossStateType.Attack,
	"dash": BossStateType.Dash,
	"hit": BossStateType.Hit,
	"die": BossStateType.Die,
	"invalid": BossStateType.Invalid
}

func _process(delta):
	var nextState: BossStateType = currentState.stateMainProcess(delta)
	if (nextState != BossStateType.Invalid):
		changeState(get_child(nextState))

func _physics_process(delta):
	var nextState: BossStateType = currentState.StatePhysicsProcess(delta)
	if (nextState != BossStateType.Invalid):
		changeState(get_child(nextState))

func get_enum_value(enumName: String):
	if STATE_DICTIONARY.has(enumName):
		return STATE_DICTIONARY[enumName]
	else:
		return BossStateType.Invalid

func can_move() -> bool:
	return currentState.can_move
