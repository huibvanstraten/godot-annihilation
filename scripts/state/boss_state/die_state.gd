class_name BossDieState
extends State

@onready var physicsComponent: PhysicsComponent = $"../../Components/PhysicsComponent"

var dieAnimationFinished: bool = false

var sfxPath: String = "res://assets/audio/sfx/slime/dying.mp3"

func enter():
	super()
	SfxManager.play(sfxPath)
	physicsComponent.velocityX = 0
	
func stateInput(_event: InputEvent) -> BossStateMachine.BossStateType:
	return BossStateMachine.BossStateType.Invalid
	
func stateMainProcess(_delta: float) -> BossStateMachine.BossStateType:
	return BossStateMachine.BossStateType.Invalid

func StatePhysicsProcess(_delta : float) -> BossStateMachine.BossStateType:
	if(dieAnimationFinished):
		get_parent().get_parent().queue_free()
		 
	return BossStateMachine.BossStateType.Invalid

func _on_animation_player_animation_finished(animName):
	if (animName == "die"):
		dieAnimationFinished = true
