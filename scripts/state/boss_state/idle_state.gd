class_name BossIdleState
extends BossState

@onready var moveChoiceComponent: MoveChoiceComponent = $"../../Components/MoveChoice"
@onready var attackComponent: AttackComponent = $"../../Components/Attack"
@export var physicsComponent: PhysicsComponent = null

@onready var timer: Timer = $Timer

var changeToNextState: bool = false
	
func enter():
	super()
	timer.start(5)
	physicsComponent.velocityX = 0.0
	

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
	elif attackComponent.playerInRange:
		return BossStateMachine.BossStateType.Attack
	elif changeToNextState:
		changeToNextState = false
		return moveChoiceComponent.choose_next_move()
	
	return BossStateMachine.BossStateType.Invalid
	
func _on_timer_timeout():
	print("timeout")
	changeToNextState = true
