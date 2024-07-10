class_name RunShootState
extends State

@onready var coyoteJumpTimer: Timer = $CoyoteJumpTimer
@onready var physicsComponent: PhysicsComponent = $"../../Components/Physics"
@onready var jumpComponent: JumpComponent = $"../../Components/Jump"

var sfxPathShoot: String = "res://assets/audio/sfx/player/shoot.wav"
var sfxPathRun: String = "res://assets/audio/sfx/player/run.wav"

func stateInput(_event: InputEvent) -> PlayerStateMachine.StateType:
	return PlayerStateMachine.StateType.Invalid
	
func stateMainProcess(_delta: float) -> PlayerStateMachine.StateType:
	return PlayerStateMachine.StateType.Invalid

func StatePhysicsProcess(_delta : float) -> PlayerStateMachine.StateType:
	var movementHorizontal: float = Input.get_axis("move_left", "move_right")
	var jumped: bool = Input.is_action_just_pressed("jump")
	var attacked : bool = Input.is_action_just_pressed("kick")
	var shoot: bool = Input.is_action_pressed("shoot")
	var crouched: bool = Input.is_action_just_pressed("crouch")
	
	var didShoot = shootComponent.shoot()
	if didShoot: SfxManager.play(sfxPathShoot)
	SfxManager.play(sfxPathRun)
	
	if entityHit:
		entityHit = false
		return PlayerStateMachine.StateType.Hit
	
	elif healthDepleted:
		healthDepleted = false
		return PlayerStateMachine.StateType.Die
	
	elif !shoot:
		return PlayerStateMachine.StateType.Run
	
	elif not characterBody.is_on_floor() and coyoteJumpTimer.is_stopped():
		if shoot:
			return PlayerStateMachine.StateType.FallShoot
		else:
			return PlayerStateMachine.StateType.Fall
	
	elif crouched:
		return PlayerStateMachine.StateType.Crouch
	
	elif jumped:
		if characterBody.is_on_floor() or coyoteJumpTimer.time_left > 0.0:
			if shoot:
				return PlayerStateMachine.StateType.JumpShoot
			else:
				return PlayerStateMachine.StateType.Jump
	
	elif attacked and characterBody.is_on_floor():
		return PlayerStateMachine.StateType.Attack
	
	elif movementHorizontal == 0 and characterBody.is_on_floor():
		if shoot:
			return PlayerStateMachine.StateType.IdleShoot
		else:
			return PlayerStateMachine.StateType.Idle
		 
	return PlayerStateMachine.StateType.Invalid
