class_name WalkState
extends EnemyState

@onready var timer: Timer = $Timer

@onready var wanderComponent: WanderComponent = $"../../Components/Wander"

var changeToIdleState = false
	
func enter():
	super()
	wanderComponent.wander_start()
	timer.start(5)

func exit():
	super()
	timer.stop()

func stateInput(_event: InputEvent) -> EnemyStateMachine.StateType:
	return EnemyStateMachine.StateType.Invalid
	
func stateMainProcess(_delta: float) -> EnemyStateMachine.StateType:
	return EnemyStateMachine.StateType.Invalid

func StatePhysicsProcess(delta : float) -> EnemyStateMachine.StateType:
	wanderComponent.change_direction()
	wanderComponent.wander(delta)
	
	if entityHit:
		entityHit = false
		return EnemyStateMachine.StateType.Hit
	elif healthDepleted:
		healthDepleted = false
		return EnemyStateMachine.StateType.Die
	elif attackComponent.playerInRange:
		return EnemyStateMachine.StateType.Attack
	elif changeToIdleState:
		changeToIdleState = false
		return EnemyStateMachine.StateType.Idle
		
	return EnemyStateMachine.StateType.Invalid

func _on_timer_timeout():
	changeToIdleState = true
