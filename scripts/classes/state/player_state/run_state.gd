class_name RunState
extends State

@onready var physicsComponent: PhysicsComponent = $"../../Components/Physics"
@onready var coyoteJumpTimer: Timer = $CoyoteJumpTimer

const NODE_NAME_AUDIO_RUN: String = "AudioRun"

var m_NodeAudioRun = null

var collisionRotation = 23.0

func initialize():
	super()
	m_NodeAudioRun = null # add later
	
func enter():
	super()
	#m_NodeAudioRun.Play()
	physicsComponent.collisionRotation = collisionRotation
	
func exit():
	#m_NodeAudioRun.Stop()
	super()
	physicsComponent.collisionRotation = 0

func stateInput(_event: InputEvent) -> PlayerStateMachine.StateType:
	return PlayerStateMachine.StateType.Invalid
	
func stateMainProcess(_delta: float) -> PlayerStateMachine.StateType:
	return PlayerStateMachine.StateType.Invalid

func StatePhysicsProcess(_delta : float) -> PlayerStateMachine.StateType:
	var movementHorizontal : float = Input.get_axis("move_left", "move_right")
	var jumped: bool = Input.is_action_just_pressed("jump")
	var attacked : bool = Input.is_action_just_pressed("kick")
	var shoot: bool = Input.is_action_just_pressed("shoot")
	var crouched: bool = Input.is_action_just_pressed("crouch")
	
	if characterBody.justLeftLedge:
		coyoteJumpTimer.start()

	if entityHit:
		entityHit = false
		return PlayerStateMachine.StateType.Hit
	
	elif healthDepleted:
		healthDepleted = false
		return PlayerStateMachine.StateType.Die
		
	elif movementHorizontal == 0 and characterBody.is_on_floor():
		return PlayerStateMachine.StateType.Idle
	
	elif crouched:
		return PlayerStateMachine.StateType.Crouch
		
	elif shoot:
		return PlayerStateMachine.StateType.Shoot 
	
	elif jumped:
		if characterBody.is_on_floor() or coyoteJumpTimer.time_left > 0.0:
			return PlayerStateMachine.StateType.Jump
		
	elif not characterBody.is_on_floor() and coyoteJumpTimer.is_stopped():
		return PlayerStateMachine.StateType.Fall
	
	elif attacked and characterBody.is_on_floor():
		return PlayerStateMachine.StateType.Attack
	
	return PlayerStateMachine.StateType.Invalid
