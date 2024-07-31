class_name BossHitState
extends State

@onready var stateMachine: BossStateMachine = $".."

var hitAnimationFinished = false

var sfxPath: String = "res://assets/audio/sfx/slime/dying.mp3"

var previousState: BossStateMachine.BossStateType = BossStateMachine.BossStateType.Invalid

func enter():
	super()
	previousState = stateMachine.get_enum_value(stateName)
	SfxManager.play(sfxPath)

func stateInput(_event: InputEvent) -> BossStateMachine.BossStateType:
	return BossStateMachine.BossStateType.Invalid
	
func stateMainProcess(_delta: float) -> BossStateMachine.BossStateType:
	return BossStateMachine.BossStateType.Invalid

func StatePhysicsProcess(_delta : float) -> BossStateMachine.BossStateType:
	if hitAnimationFinished:
		hitAnimationFinished = false
		return previousState
	return BossStateMachine.BossStateType.Invalid
		
func _on_animation_player_animation_finished(animName):
	if animName == "hit":
		hitAnimationFinished = true
