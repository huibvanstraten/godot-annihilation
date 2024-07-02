class_name AttackState
extends State

const NODE_NAME_AUDIO_ATTACK: String = "AudioAttack"

var m_NodeAudioAttack = null

var attackAnimationFinished: bool = false

func enter():
	super()
	
	
func stateInput(_event: InputEvent) -> PlayerStateMachine.StateType:
	return PlayerStateMachine.StateType.Invalid
	
func stateMainProcess(_delta: float) -> PlayerStateMachine.StateType:
	return PlayerStateMachine.StateType.Invalid

func StatePhysicsProcess(_delta : float) -> PlayerStateMachine.StateType:
	
	if entityHit:
		entityHit = false
		return PlayerStateMachine.StateType.Hit
	
	elif healthDepleted:
		healthDepleted = false
		return PlayerStateMachine.StateType.Die
	
	elif attackAnimationFinished:
		attackAnimationFinished = false
		return PlayerStateMachine.StateType.Idle
		 
	return PlayerStateMachine.StateType.Invalid

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "strike":
		attackAnimationFinished = true
