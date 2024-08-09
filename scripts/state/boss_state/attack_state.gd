class_name BossAttackState
extends State

@onready var timer: Timer = $Timer
@export var attackComponent: AttackComponent = null

var changeState: bool = false

func enter():
	super()
	timer.start()

func exit():
	super()

func stateInput(_event: InputEvent) -> BossStateMachine.BossStateType:
	return BossStateMachine.BossStateType.Invalid
	
func stateMainProcess(_delta: float) -> BossStateMachine.BossStateType:
	return BossStateMachine.BossStateType.Invalid

func StatePhysicsProcess(_delta : float) -> BossStateMachine.BossStateType:
	if !attackComponent.playerInRange:
		return BossStateMachine.BossStateType.Walk
	if changeState:
		changeState = false
		return BossStateMachine.BossStateType.Idle
	
	return BossStateMachine.BossStateType.Invalid


func _on_timer_timeout():
	changeState = true
