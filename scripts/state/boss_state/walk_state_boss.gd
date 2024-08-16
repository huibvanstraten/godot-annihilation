class_name BossWalkState
extends BossState

@onready var attackComponent: AttackComponent = $"../../Components/Attack"
@onready var stateComponent: StateComponent = $"../../Components/State"

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
	walkComponent.select_walking_position()
	stateComponent.start_walk_state_timer()

func stateInput(_event: InputEvent) -> BossStateMachine.BossStateType:
	return BossStateMachine.BossStateType.Invalid
	
func stateMainProcess(_delta: float) -> BossStateMachine.BossStateType:
	return BossStateMachine.BossStateType.Invalid

func StatePhysicsProcess(_delta : float) -> BossStateMachine.BossStateType:
	
	if entityHit:
		entityHit = false
		return BossStateMachine.BossStateType.Hit
	elif healthDepleted:
		healthDepleted = false
		return BossStateMachine.BossStateType.Die
	elif attackComponent.playerInRange and !stateComponent.toWalkState:
		return BossStateMachine.BossStateType.Attack
	elif changeToDashState:
		changeToDashState = false
		stateComponent.stop_walk_state_timer()
		return BossStateMachine.BossStateType.Dash
		
	return BossStateMachine.BossStateType.Invalid
