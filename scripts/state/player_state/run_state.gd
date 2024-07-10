class_name RunState
extends State

@onready var physicsComponent: PhysicsComponent = $"../../Components/Physics"
@onready var coyoteJumpTimer: Timer = $CoyoteJumpTimer

var sfxPath: String = "res://assets/audio/sfx/player/run.wav"

func initialize():
	super()
	
func enter():
	super()
	
func exit():
	#m_NodeAudioRun.Stop()
	super()

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
	
	SfxManager.play(sfxPath)
	
	if characterBody.justLeftLedge:
		coyoteJumpTimer.start()

	if entityHit:
		entityHit = false
		return PlayerStateMachine.StateType.Hit
	
	elif healthDepleted:
		healthDepleted = false
		return PlayerStateMachine.StateType.Die
	
	elif crouched:
		return PlayerStateMachine.StateType.Crouch
		
	elif shoot:
		return PlayerStateMachine.StateType.RunShoot 
	
	elif jumped:
		if characterBody.is_on_floor() or coyoteJumpTimer.time_left > 0.0:
			return PlayerStateMachine.StateType.Jump
	
	elif attacked and characterBody.is_on_floor():
		return PlayerStateMachine.StateType.Attack
		
	elif movementHorizontal == 0 and characterBody.is_on_floor():
		return PlayerStateMachine.StateType.Idle
			
	elif not characterBody.is_on_floor() and coyoteJumpTimer.is_stopped():
		return PlayerStateMachine.StateType.Fall
	
	return PlayerStateMachine.StateType.Invalid
