class_name BossMushroomState
extends State

@export var mushroomComponent: MushroomComponent = null

func enter():
	super()
	mushroomComponent.grow_mushrooms()
	mushroomComponent.isPlayerParalyzed = false
	mushroomComponent.areMushroomsGrown = false

func exit():
	super()

func stateInput(_event: InputEvent) -> BossStateMachine.BossStateType:
	return BossStateMachine.BossStateType.Invalid
	
func stateMainProcess(_delta: float) -> BossStateMachine.BossStateType:
	return BossStateMachine.BossStateType.Invalid

func StatePhysicsProcess(_delta : float) -> BossStateMachine.BossStateType:
	#if mushroomComponent.areMushroomsGrown:
		#mushroomComponent.areMushroomsGrown = false
		#return BossStateMachine.BossStateType.Idle
		
	if mushroomComponent.isPlayerParalyzed:
		mushroomComponent.remove_all_mushrooms()
		return BossStateMachine.BossStateType.Laser
	
	return BossStateMachine.BossStateType.Invalid
