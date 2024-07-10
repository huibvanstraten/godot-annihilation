class_name FallState
extends State

@onready var physicsComponent: PhysicsComponent = $"../../Components/Physics"
@onready var ledgeComponent: LedgeComponent = $"../../Components/Ledge"

@onready var wallDetector: RayCast2D = $"../../FlipMarker/WallDetector"

var sfxPath: String = "res://assets/audio/sfx/player/landing.wav"

func exit():
	super()
	SfxManager.play(sfxPath)

func stateInput(_event: InputEvent) -> PlayerStateMachine.StateType:
	return PlayerStateMachine.StateType.Invalid
	
func stateMainProcess(_delta: float) -> PlayerStateMachine.StateType:
	return PlayerStateMachine.StateType.Invalid

func StatePhysicsProcess(_delta : float) -> PlayerStateMachine.StateType:
	var wall_cling: float = Input.is_action_pressed("wall cling")
	var jump: float = Input.is_action_pressed("jump")
	var shoot: bool = Input.is_action_pressed("shoot")
	
	jumpBuffer()
	
	if entityHit:
		entityHit = false
		return PlayerStateMachine.StateType.Hit
	
	elif healthDepleted:
		healthDepleted = false
		return PlayerStateMachine.StateType.Die
		
	elif ledgeComponent.canClimbLedge() and jump:
		return PlayerStateMachine.StateType.Ledge
	
	elif wall_cling and characterBody.is_on_wall_only() and wallDetector.is_colliding():
		return PlayerStateMachine.StateType.Wall
		
	elif shoot:
		return PlayerStateMachine.StateType.FallShoot 
		
	elif jumpBufferCounter > 0 and characterBody.is_on_floor():
		jumpBufferCounter = 0
		return PlayerStateMachine.StateType.Jump
	
	elif characterBody.velocity.y == 0 and characterBody.is_on_floor():
		physicsComponent.reset_velocity()
		return PlayerStateMachine.StateType.Idle
	
	return PlayerStateMachine.StateType.Invalid
