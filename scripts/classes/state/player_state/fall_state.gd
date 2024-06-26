class_name FallState
extends State

@onready var physicsComponent: PhysicsComponent = $"../../Components/Physics"
@onready var ledgeComponent: LedgeComponent = $"../../Components/Ledge"

@onready var wallDetector: RayCast2D = $"../../FlipMarker/WallDetector"

const NODE_NAME_AUDIO_FALL: String = "AudioFall"
var nodeAudioFall = null

func enter():
	super()

func stateInput(_event: InputEvent) -> PlayerStateMachine.StateType:
	return PlayerStateMachine.StateType.Invalid
	
func stateMainProcess(_delta: float) -> PlayerStateMachine.StateType:
	return PlayerStateMachine.StateType.Invalid

func StatePhysicsProcess(_delta : float) -> PlayerStateMachine.StateType:
	var wall_cling: float = Input.is_action_just_pressed("wall cling")
	var jump: float = Input.is_action_pressed("jump")
	
	if entityHit:
		entityHit = false
		return PlayerStateMachine.StateType.Hit
	
	elif healthDepleted:
		healthDepleted = false
		return PlayerStateMachine.StateType.Die
		
	elif ledgeComponent.canClimbLedge(physicsComponent.direction.x > 0) and jump:
		return PlayerStateMachine.StateType.Ledge
	
	elif wall_cling and characterBody.is_on_wall_only() and wallDetector.is_colliding():
		return PlayerStateMachine.StateType.Wall
		
	elif characterBody.velocity.y == 0 and characterBody.is_on_floor():
		return PlayerStateMachine.StateType.Idle
	
	return PlayerStateMachine.StateType.Invalid
