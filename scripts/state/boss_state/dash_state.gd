class_name BossDashState
extends BossState

@export var dashComponent: DashComponent= null

var changeToJumpState: bool = false

func initialize():
	super()
	EventManager.position_reached.connect(
		func(currentStateName): 
		if currentStateName == stateName:
			changeToJumpState = true
		)

func enter():
	super()
	dashComponent.dash_position()

func stateInput(_event: InputEvent) -> BossStateMachine.BossStateType:
	return BossStateMachine.BossStateType.Invalid
	
func stateMainProcess(_delta: float) -> BossStateMachine.BossStateType:
	return BossStateMachine.BossStateType.Invalid

func StatePhysicsProcess(_delta : float) -> BossStateMachine.BossStateType:
	if changeToJumpState:
		changeToJumpState = false
		return BossStateMachine.BossStateType.Jump
	
	return BossStateMachine.BossStateType.Invalid
