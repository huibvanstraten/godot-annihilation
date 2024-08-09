class_name BossMushroomState
extends BossState

@export var mushroomComponent: MushroomComponent = null

func enter():
	super()
	mushroomComponent.grow_mushrooms()
	mushroomComponent.isPlayerParalyzed = false
	mushroomComponent.areMushroomsGrown = false
	mushroomComponent.allMushroomsExploded = false

func exit():
	super()

func stateInput(_event: InputEvent) -> BossStateMachine.BossStateType:
	return BossStateMachine.BossStateType.Invalid
	
func stateMainProcess(_delta: float) -> BossStateMachine.BossStateType:
	return BossStateMachine.BossStateType.Invalid

func StatePhysicsProcess(delta : float) -> BossStateMachine.BossStateType:
	walkComponent.stop_wander(delta)
		
	if mushroomComponent.isPlayerParalyzed:
		mushroomComponent.remove_all_mushrooms()
		return BossStateMachine.BossStateType.Laser
	elif mushroomComponent.allMushroomsExploded:
		return BossStateMachine.BossStateType.Idle
	
	return BossStateMachine.BossStateType.Invalid
