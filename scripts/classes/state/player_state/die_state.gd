class_name DieState
extends State

const NODE_NAME_AUDIO_DIE: String = "AudioDie"

var m_NodeAudioDie = null

var dieAnimationFinished: bool = false

func stateInput(_event: InputEvent) -> PlayerStateMachine.StateType:
	return PlayerStateMachine.StateType.Invalid
	
func stateMainProcess(_delta: float) -> PlayerStateMachine.StateType:
	return PlayerStateMachine.StateType.Invalid

func StatePhysicsProcess(_delta : float) -> PlayerStateMachine.StateType:
	if dieAnimationFinished:
		EventManager.emit_signal("player_died")
		return PlayerStateMachine.StateType.Idle
	
	return PlayerStateMachine.StateType.Invalid

func _on_animation_player_animation_finished(animName):
	if animName == "die":
		dieAnimationFinished = true
