class_name EnemyDieState
extends EnemyState

@onready var physicsComponent: PhysicsComponent = $"../../Components/Physics"

var dieAnimationFinished: bool = false

var sfxPath: String = "res://assets/audio/sfx/slime/dying.mp3"

func enter():
	super()
	SfxManager.play(sfxPath)
	physicsComponent.velocityX = 0
	
func stateInput(_event: InputEvent) -> EnemyStateMachine.StateType:
	return EnemyStateMachine.StateType.Invalid
	
func stateMainProcess(_delta: float) -> EnemyStateMachine.StateType:
	return EnemyStateMachine.StateType.Invalid

func StatePhysicsProcess(_delta : float) -> EnemyStateMachine.StateType:
	if(dieAnimationFinished):
		get_parent().get_parent().queue_free()
		 
	return EnemyStateMachine.StateType.Invalid

func _on_animation_player_animation_finished(animName):
	if (animName == "die"):
		dieAnimationFinished = true
