class_name EnemyIdleState
extends EnemyState

@onready var timer: Timer = $Timer 
@onready var wanderComponent: WanderComponent = $"../../Components/Wander"

var changeToWalkState: bool = false
	
func enter():
	super()
	timer.start(3)

func exit():
	super()
	timer.stop()

func stateInput(_event: InputEvent) -> EnemyStateMachine.StateType:
	return EnemyStateMachine.StateType.Invalid
	
func stateMainProcess(_delta: float) -> EnemyStateMachine.StateType:
	return EnemyStateMachine.StateType.Invalid

func StatePhysicsProcess(delta : float) -> EnemyStateMachine.StateType:
	wanderComponent.stop_wander(delta)
	
	if entityHit:
		entityHit = false
		return EnemyStateMachine.StateType.Hit
	elif healthDepleted:
		healthDepleted = false
		return EnemyStateMachine.StateType.Die
	elif attackComponent.playerInRange:
		return EnemyStateMachine.StateType.Attack
	elif changeToWalkState:
		changeToWalkState = false
		return EnemyStateMachine.StateType.Walk
	
	return EnemyStateMachine.StateType.Invalid
	
func _on_timer_timeout():
	changeToWalkState = true
