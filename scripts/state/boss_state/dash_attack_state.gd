class_name BossDashAttackState
extends State

func enter():
	super()

func exit():
	super()

func stateInput(_event: InputEvent) -> BossStateMachine.BossStateType:
	return BossStateMachine.BossStateType.Invalid
	
func stateMainProcess(_delta: float) -> BossStateMachine.BossStateType:
	return BossStateMachine.BossStateType.Invalid

func StatePhysicsProcess(delta : float) -> BossStateMachine.BossStateType:
	if true:
		return BossStateMachine.BossStateType.Idle
	
	return BossStateMachine.BossStateType.Invalid
