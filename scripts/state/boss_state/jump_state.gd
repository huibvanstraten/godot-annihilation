class_name BossJumpState
extends State

@onready var physicsComponent: PhysicsComponent = $"../../Components/Physics"
@onready var jumpComponent: BossJumpComponent = $"../../Components/Jump"
@onready var positionComponent: PositionComponent = $"../../Components/Position"
@onready var bombComponent: BombComponent = $"../../Components/Bomb"

var sfxPath: String = "res://assets/audio/sfx/player/jump.wav"

var changeToIdleState: bool = true

func initialize():
	super()
	EventManager.position_reached.connect(
	func(currentStateName): 
		if currentStateName == stateName:
			changeToIdleState = true
	)
	
func enter():
	super()
	SfxManager.play(sfxPath)
	positionComponent.select_position()

func exit():
	super()
	
func stateInput(_event: InputEvent) -> BossStateMachine.BossStateType:
	return BossStateMachine.BossStateType.Invalid
	
func stateMainProcess(_delta: float) -> BossStateMachine.BossStateType:
	return BossStateMachine.BossStateType.Invalid

func StatePhysicsProcess(_delta : float) -> BossStateMachine.BossStateType:
	bombComponent.shoot()
	if entityHit:
		entityHit = false
		return BossStateMachine.BossStateType.Hit

	elif healthDepleted:
		healthDepleted = false
		return BossStateMachine.BossStateType.Die
	
	elif changeToIdleState:
		changeToIdleState = false
		print("changing to idle state")
		return BossStateMachine.BossStateType.Idle
	
	return BossStateMachine.BossStateType.Invalid
