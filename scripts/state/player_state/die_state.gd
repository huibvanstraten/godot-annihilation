class_name DieState
extends State

var dieAnimationFinished: bool = false

var sfxPath: String = "res://assets/audio/sfx/player/hit.mp3"

func enter():
	super()
	SfxManager.play(sfxPath)

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
