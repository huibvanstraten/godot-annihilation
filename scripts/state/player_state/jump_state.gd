class_name JumpState
extends State

@onready var physicsComponent: PhysicsComponent = $"../../Components/Physics"
@onready var jumpComponent: JumpComponent = $"../../Components/Jump"
@onready var ledgeComponent: LedgeComponent = $"../../Components/Ledge"

@onready var wallDetector: RayCast2D = $"../../FlipMarker/WallDetector"

const NODE_NAME_AUDIO_JUMP: String = "AudioJump"

var m_NodeAudioJump = null

func initialize():
	super()
	m_NodeAudioJump = null # add later
	
func enter():
	super()
	#m_NodeAudioJump.Play()
	if jumpComponent.wallJump == true:
		canMove = false
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
	var playerShoot: bool = Input.is_action_just_pressed("shoot")
	var jump: bool = Input.is_action_just_pressed("jump")
	
	jumpComponent.stop_jump(false)

	if entityHit:
		entityHit = false
		return PlayerStateMachine.StateType.Hit
	
	elif healthDepleted:
		healthDepleted = false
		return PlayerStateMachine.StateType.Die
	
	elif playerShoot:
		return PlayerStateMachine.StateType.JumpShoot 
		
	elif characterBody.is_on_ceiling():
		jumpComponent.stop_jump(true)
		return PlayerStateMachine.StateType.Fall
	
	elif characterBody.velocity.y >= 0:
		if characterBody.is_on_floor():
			return PlayerStateMachine.StateType.Idle
		else:
			return PlayerStateMachine.StateType.Fall
		
	elif wall_cling and characterBody.is_on_wall_only() and wallDetector.is_colliding():
		return PlayerStateMachine.StateType.Wall
	
	return PlayerStateMachine.StateType.Invalid
