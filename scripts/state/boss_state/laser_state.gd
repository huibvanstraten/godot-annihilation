class_name BossLaserState
extends State

@onready var laserComponent: LaserComponent = $"../../Components/Laser"

func enter():
	super()
	laserComponent.instantiate_laser()

func stateInput(_event: InputEvent) -> BossStateMachine.BossStateType:
	return BossStateMachine.BossStateType.Invalid
	
func stateMainProcess(_delta: float) -> BossStateMachine.BossStateType:
	return BossStateMachine.BossStateType.Invalid

func StatePhysicsProcess(_delta : float) -> BossStateMachine.BossStateType:
	if laserComponent.shouldEndLaserState:
		laserComponent.shouldEndLaserState = false
		return BossStateMachine.BossStateType.Idle
	
	return BossStateMachine.BossStateType.Invalid
