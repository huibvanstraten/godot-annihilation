class_name EnemyHitState
extends EnemyState

var hit_animation_finished = false

var sfxPath: String = "res://assets/audio/sfx/slime/dying.mp3"

func enter():
	super()
	SfxManager.play(sfxPath)

func stateInput(_event: InputEvent) -> EnemyStateMachine.StateType:
	return EnemyStateMachine.StateType.Invalid
	
func stateMainProcess(_delta: float) -> EnemyStateMachine.StateType:
	return EnemyStateMachine.StateType.Invalid

func StatePhysicsProcess(_delta : float) -> EnemyStateMachine.StateType:
	if hit_animation_finished:
		hit_animation_finished = false
		return EnemyStateMachine.StateType.Idle
	return EnemyStateMachine.StateType.Invalid
		
func _on_animation_player_animation_finished(anim_name):
	if anim_name == "hit":
		hit_animation_finished = true
