class_name PlayerStateMachine
extends StateMachine

enum StateType { Idle, Run, Jump, Fall, Attack, Hit, Die, Wall, Crouch, Ledge, IdleShoot, RunShoot, JumpShoot, FallShoot, Paralyzed, Invalid }

var stateTypeDict = {
	"Idle": StateType.Idle,
	"Run": StateType.Run,
	"Jump": StateType.Jump,
	"Fall": StateType.Fall,
	"Attack": StateType.Attack,
	"Hit": StateType.Hit,
	"Die": StateType.Die,
	"Wall": StateType.Wall,
	"crouch": StateType.Crouch,
	"ledge": StateType.Ledge,
	"idle_shoot": StateType.IdleShoot,
	"run_shoot": StateType.RunShoot,
	"jump_shoot": StateType.JumpShoot,
	"fall_shoot": StateType.FallShoot,
	"Invalid": StateType.Invalid,
	"Paralyzed": StateType.Paralyzed
	}

func _ready():
	super()
	EventManager.connect("freeze_player", _freeze_state_machine)

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

func _freeze_state_machine(freeze: bool):
	changeState(get_child(StateType.Idle))
	set_physics_process(!freeze)
