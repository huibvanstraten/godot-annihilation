class_name IdleState
extends State

func stateInput(_event: InputEvent) -> PlayerStateMachine.StateType:
	return PlayerStateMachine.StateType.Invalid
	
func stateMainProcess(_delta: float) -> PlayerStateMachine.StateType:
	return PlayerStateMachine.StateType.Invalid

func StatePhysicsProcess(_delta : float) -> PlayerStateMachine.StateType:
	var movementHorizontal: float = Input.get_axis("move_left", "move_right")
	var jumped: bool = Input.is_action_just_pressed("jump")
	var attacked : bool = Input.is_action_just_pressed("kick")
	var shoot: bool = Input.is_action_just_pressed("shoot")
	var crouched: bool = Input.is_action_just_pressed("crouch")
	
	if entityHit:
		entityHit = false
		return PlayerStateMachine.StateType.Hit
	
	elif healthDepleted:
		healthDepleted = false
		return PlayerStateMachine.StateType.Die
	
	elif shoot:
		return PlayerStateMachine.StateType.Shoot 
		
	elif crouched:
		return PlayerStateMachine.StateType.Crouch
	
	elif movementHorizontal != 0 and characterBody.is_on_floor():
		return PlayerStateMachine.StateType.Run
		 
	elif jumped and characterBody.is_on_floor():
		return PlayerStateMachine.StateType.Jump
		
	elif not characterBody.is_on_floor():
		return PlayerStateMachine.StateType.Fall
	
	elif attacked and characterBody.is_on_floor():
		return PlayerStateMachine.StateType.Attack
	
	return PlayerStateMachine.StateType.Invalid
