class_name CrouchState
extends State

@onready var physicsComponent: PhysicsComponent = $"../../Components/Physics"

func enter():
	super()

func exit():
	super()
	physicsComponent.collisionSizeY = 1

func stateInput(_event: InputEvent) -> PlayerStateMachine.StateType:
	return PlayerStateMachine.StateType.Invalid
	
func stateMainProcess(_delta: float) -> PlayerStateMachine.StateType:
	return PlayerStateMachine.StateType.Invalid

func StatePhysicsProcess(_delta : float) -> PlayerStateMachine.StateType:
	var movementHorizontal: float = Input.get_axis("move_left", "move_right")
	var stand: float = Input.is_action_just_released("crouch")
	var characterJumped: bool = Input.is_action_just_pressed("jump")
	var playerAttacked : bool = Input.is_action_just_pressed("kick")
	var playerShoot: bool = Input.is_action_just_pressed("shoot")
	
	if entityHit:
		entityHit = false
		return PlayerStateMachine.StateType.Hit
	
	elif healthDepleted:
		healthDepleted = false
		return PlayerStateMachine.StateType.Die
	
	elif playerShoot:
		return PlayerStateMachine.StateType.Shoot 
	
	elif movementHorizontal != 0 and characterBody.is_on_floor():
		return PlayerStateMachine.StateType.Run
		 
	elif characterJumped and characterBody.is_on_floor():
		return PlayerStateMachine.StateType.Jump
	
	elif playerAttacked and characterBody.is_on_floor():
		return PlayerStateMachine.StateType.Attack
	
	elif stand:
		return PlayerStateMachine.StateType.Idle
	
	return PlayerStateMachine.StateType.Invalid
