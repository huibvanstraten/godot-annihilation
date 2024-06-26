class_name ShootState
extends State

@onready var coyoteJumpTimer: Timer = $CoyoteJumpTimer
@onready var physicsComponent: PhysicsComponent = $"../../Components/Physics"

const NODE_NAME_AUDIO_ATTACK: String = "AudioShoot"

var m_NodeAudioAttack = null

var shootAnimationFinished: bool = false

var previousState: String

func enter():
	previousState = get_previous_state_type(characterBody)
	if previousState == "idle":
		canMove = false
	else: 
		canMove = true
		
	animationName = shootComponent.shooting_animation(previousState)
	super()
	shootComponent.shoot()
	
func stateInput(_event: InputEvent) -> PlayerStateMachine.StateType:
	return PlayerStateMachine.StateType.Invalid
	
func stateMainProcess(_delta: float) -> PlayerStateMachine.StateType:
	return PlayerStateMachine.StateType.Invalid

func StatePhysicsProcess(_delta : float) -> PlayerStateMachine.StateType:
	var movementHorizontal : float = Input.get_axis("move_left", "move_right")
	var characterJumped: bool = Input.is_action_just_pressed("jump")
	
	if characterBody.justLeftLedge:
		coyoteJumpTimer.start()
	
	if entityHit:
		entityHit = false
		return PlayerStateMachine.StateType.Hit
	
	elif healthDepleted:
		healthDepleted = false
		return PlayerStateMachine.StateType.Die
	
	elif previousState == "run":
		if movementHorizontal == 0:
			return PlayerStateMachine.StateType.Idle
		elif not characterBody.is_on_floor() and coyoteJumpTimer.is_stopped():
			return PlayerStateMachine.StateType.Fall
		elif characterJumped:
			if  characterBody.is_on_floor() or coyoteJumpTimer.time_left > 0.0:
				return PlayerStateMachine.StateType.Jump
			elif not characterBody.is_on_floor() and coyoteJumpTimer.is_stopped():
				return PlayerStateMachine.StateType.Fall
	
	elif previousState == "jump" and characterBody.velocity.y == 0 or previousState == "crouch":
		return PlayerStateMachine.StateType.Idle
	
	elif shootAnimationFinished:
		shootAnimationFinished = false
		return PlayerStateMachine.StateType.Idle
		 
	return PlayerStateMachine.StateType.Invalid

func _on_animation_player_animation_finished(animName):
	if animName == "idle_shoot" or animName == "run_shoot" or animName == "jump_shoot" or animName == "fall_shoot" or animName == "wall_shoot":
		shootAnimationFinished = true
