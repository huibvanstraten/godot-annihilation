class_name FallShootState
extends State

@onready var physicsComponent: PhysicsComponent = $"../../Components/Physics"
@onready var ledgeComponent: LedgeComponent = $"../../Components/Ledge"

@onready var wallDetector: RayCast2D = $"../../FlipMarker/WallDetector"

var sfxPathShoot: String = "res://assets/audio/sfx/player/shoot.wav"
var sfxPathLand: String = "res://assets/audio/sfx/player/landing.wav"

func stateInput(_event: InputEvent) -> PlayerStateMachine.StateType:
	return PlayerStateMachine.StateType.Invalid
	
func stateMainProcess(_delta: float) -> PlayerStateMachine.StateType:
	return PlayerStateMachine.StateType.Invalid

func StatePhysicsProcess(_delta : float) -> PlayerStateMachine.StateType:
	var wall_cling: float = Input.is_action_pressed("wall cling")
	var jump: float = Input.is_action_pressed("jump")
	var shoot: bool = Input.is_action_pressed("shoot")
	
	jumpBuffer()
	
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
		return PlayerStateMachine.StateType.Fall 
		
	elif ledgeComponent.canClimbLedge() and jump:
		return PlayerStateMachine.StateType.Ledge
	
	elif wall_cling and characterBody.is_on_wall_only() and wallDetector.is_colliding():
		return PlayerStateMachine.StateType.Wall
		
	elif jumpBufferCounter > 0 and characterBody.is_on_floor():
		SfxManager.play(sfxPathLand)
		jumpBufferCounter = 0
		if shoot:
			return PlayerStateMachine.StateType.JumpShoot
		else:
			return PlayerStateMachine.StateType.Jump
	
	elif characterBody.velocity.y == 0 and characterBody.is_on_floor():
		SfxManager.play(sfxPathLand)
		physicsComponent.reset_velocity()
		if shoot:
			return PlayerStateMachine.StateType.IdleShoot
		else:
			return PlayerStateMachine.StateType.Idle
	
	return PlayerStateMachine.StateType.Invalid
