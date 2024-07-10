class_name AttackingState
extends EnemyState

var sfxPath: String = "res://assets/audio/sfx/slime/roar.wav"

func enter():
	super()
	SfxManager.play(sfxPath)

func stateInput(_event: InputEvent) -> EnemyStateMachine.StateType:
	return EnemyStateMachine.StateType.Invalid
	
func stateMainProcess(_delta: float) -> EnemyStateMachine.StateType:
	return EnemyStateMachine.StateType.Invalid

func StatePhysicsProcess(_delta : float) -> EnemyStateMachine.StateType:
	if entityHit:
		entityHit = false
		return EnemyStateMachine.StateType.Hit
	elif healthDepleted:
		healthDepleted = false
		return EnemyStateMachine.StateType.Die
	elif !attackComponent.playerInRange:
		return EnemyStateMachine.StateType.Idle
	
	return EnemyStateMachine.StateType.Invalid
