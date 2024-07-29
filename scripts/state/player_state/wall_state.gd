class_name WallState
extends State

@onready var physicsComponent: PhysicsComponent = $"../../Components/Physics"
@onready var jumpComponent: JumpComponent = $"../../Components/Jump"

@onready var wallDetector: RayCast2D = $"../../FlipMarker/WallDetector"

const NODE_NAME_AUDIO_JUMP: String = "AudioJump"

var m_NodeAudioJump = null

var didWallJump: bool = false

func enter():
	super()
	#m_NodeAudioJump.Play()
	physicsComponent.velocityY = 0
	physicsComponent.gravity = 300

func exit():
	physicsComponent.reset_gravity()
	
func stateInput(_event: InputEvent) -> PlayerStateMachine.StateType:
	return PlayerStateMachine.StateType.Invalid
	
func stateMainProcess(_delta: float) -> PlayerStateMachine.StateType:
	return PlayerStateMachine.StateType.Invalid

func StatePhysicsProcess(_delta : float) -> PlayerStateMachine.StateType:
	var wallClingReleased: float = Input.is_action_just_released("wall cling")
	var characterJumped: bool = Input.is_action_just_pressed("jump")

	if entityHit:
		entityHit = false
		return PlayerStateMachine.StateType.Hit

	elif isParalyzed:
		isParalyzed = false
		return PlayerStateMachine.StateType.Paralyzed

	elif healthDepleted:
		healthDepleted = false
		return PlayerStateMachine.StateType.Die
			 
	elif characterBody.is_on_floor():
		return PlayerStateMachine.StateType.Idle
	
	elif characterJumped:
		jumpComponent.wallJump = true
		return PlayerStateMachine.StateType.Jump
	
	elif wallClingReleased or !wallDetector.is_colliding():
		return PlayerStateMachine.StateType.Fall
	
	return PlayerStateMachine.StateType.Invalid
