class_name BossWalkState
extends State

@onready var timer: Timer = $Timer

@onready var wanderComponent: BossWalkComponent = $"../../Components/Walk"
@onready var attackComponent: AttackComponent = $"../../Components/Attack"

var changeToIdleState = false
	
func enter():
	super()
	wanderComponent.wander_start()
	timer.start(10)

func exit():
	super()
	timer.stop()

func stateInput(_event: InputEvent) -> BossStateMachine.BossStateType:
	return BossStateMachine.BossStateType.Invalid
	
func stateMainProcess(_delta: float) -> BossStateMachine.BossStateType:
	return BossStateMachine.BossStateType.Invalid

func StatePhysicsProcess(delta : float) -> BossStateMachine.BossStateType:
	wanderComponent.change_direction()
	wanderComponent.wander(delta)
	
	if entityHit:
		entityHit = false
		return BossStateMachine.BossStateType.Hit
	elif healthDepleted:
		healthDepleted = false
		return BossStateMachine.BossStateType.Die
	if attackComponent.playerInRange:
		return BossStateMachine.BossStateType.DashAttack
	elif changeToIdleState:
		changeToIdleState = false
		return BossStateMachine.BossStateType.Idle
		
	return BossStateMachine.BossStateType.Invalid

func _on_timer_timeout():
	changeToIdleState = true
