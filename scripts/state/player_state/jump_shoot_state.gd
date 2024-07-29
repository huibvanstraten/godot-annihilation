class_name JumpShootState
extends State

@onready var physicsComponent: PhysicsComponent = $"../../Components/Physics"
@onready var jumpComponent: JumpComponent = $"../../Components/Jump"
@onready var ledgeComponent: LedgeComponent = $"../../Components/Ledge"

@onready var wallDetector: RayCast2D = $"../../FlipMarker/WallDetector"

var sfxPathShoot: String = "res://assets/audio/sfx/player/shoot.wav"
var sfxPathJump: String = "res://assets/audio/sfx/player/jump.wav"

func enter():
	super()
	SfxManager.play(sfxPathJump)
	if jumpComponent.wallJump == true:
		canMove = false
	
	var previousState = get_previous_state_type(characterBody)
	if previousState == "jump":
		pass
	else:
		jumpComponent.jump()
		
	
func exit():
	super()
	canMove = true
	
func stateInput(_event: InputEvent) -> PlayerStateMachine.StateType:
	return PlayerStateMachine.StateType.Invalid
	
func stateMainProcess(_delta: float) -> PlayerStateMachine.StateType:
	return PlayerStateMachine.StateType.Invalid

func StatePhysicsProcess(_delta : float) -> PlayerStateMachine.StateType:
	var wall_cling: float = Input.is_action_pressed("wall cling")
	var shoot: bool = Input.is_action_pressed("shoot")
	var jump: bool = Input.is_action_pressed("jump")
	
	jumpComponent.stop_jump(false)
	var didShoot = shootComponent.shoot()
	if didShoot: SfxManager.play(sfxPathShoot)

	if entityHit:
		entityHit = false
		return PlayerStateMachine.StateType.Hit

	elif isParalyzed:
		isParalyzed = false
		return PlayerStateMachine.StateType.Paralyzed

	elif healthDepleted:
		healthDepleted = false
		return PlayerStateMachine.StateType.Die
	
	elif !shoot:
		return PlayerStateMachine.StateType.Jump 
	
	elif ledgeComponent.canClimbLedge() and jump:
		return PlayerStateMachine.StateType.Ledge
		
	elif characterBody.is_on_ceiling():
		jumpComponent.stop_jump(true)
		if shoot:
			return PlayerStateMachine.StateType.FallShoot
		else:
			return PlayerStateMachine.StateType.Fall
	
	elif characterBody.velocity.y >= 0:
		if characterBody.is_on_floor():
			if shoot:
				return PlayerStateMachine.StateType.IdleShoot
			else:
				return PlayerStateMachine.StateType.Idle
		else:
			if shoot:
				return PlayerStateMachine.StateType.FallShoot
			else:
				return PlayerStateMachine.StateType.Fall
		
	elif wall_cling and characterBody.is_on_wall_only() and wallDetector.is_colliding():
		return PlayerStateMachine.StateType.Wall
	
	return PlayerStateMachine.StateType.Invalid
