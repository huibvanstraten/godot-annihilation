class_name BossWalkState
extends BossState

@onready var timer: Timer = $Timer
@onready var attackComponent: AttackComponent = $"../../Components/Attack"

var changeToDashState = false

func initialize():
	super()
	EventManager.position_reached.connect(
	func(currentStateName): 
		if currentStateName == stateName:
			changeToDashState = true
		)
	
func enter():
	super()
	timer.start(5)
	walkComponent.select_walking_position()

func exit():
	super()
	timer.stop()
	

func stateInput(_event: InputEvent) -> BossStateMachine.BossStateType:
	return BossStateMachine.BossStateType.Invalid
	
func stateMainProcess(_delta: float) -> BossStateMachine.BossStateType:
	return BossStateMachine.BossStateType.Invalid

func StatePhysicsProcess(delta : float) -> BossStateMachine.BossStateType:
	
	if entityHit:
		entityHit = false
		return BossStateMachine.BossStateType.Hit
	elif healthDepleted:
		healthDepleted = false
		return BossStateMachine.BossStateType.Die
	if attackComponent.playerInRange:
		return BossStateMachine.BossStateType.Attack
	elif changeToDashState:
		changeToDashState = false
		return BossStateMachine.BossStateType.Dash
		
	return BossStateMachine.BossStateType.Invalid
