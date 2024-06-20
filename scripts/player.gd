class_name Player
extends Entity

var justLeftLedge: bool = false

func on_save_game(saved_data: Array[SavedData]):
	var my_data = SavedData.new()
	my_data.level_scene_path = scene_file_path
	
	saved_data.append(my_data)

func on_load_game(saved_data:SavedData):
	if saved_data is SavedPlayerData:
			pass

func _physics_process(delta):
	var inputAxis = Input.get_axis("move_left", "move_right")
	var currentState = stateMachine.currentState
	
	if currentState is DieState:
		physicsComponent.velocityX = 0
	
	if currentState is HitState: 
		physicsComponent.knock_back()
		
	if not is_on_floor():
		physicsComponent.set_gravity(delta)
		
		if inputAxis != 0 and stateMachine.can_move():
			physicsComponent.move_in_air(delta, inputAxis)
			flip(true)
		elif inputAxis == 0 and currentState != HitState:
			physicsComponent.air_resistance(delta)
	
	else:
		if inputAxis != 0 and stateMachine.can_move():
			physicsComponent.move(delta, inputAxis)
			flip(true)
		elif inputAxis == 0 and currentState != HitState:
			physicsComponent.stop(delta)
		
	move_and_slide_with_coyote_jump()

func move_and_slide_with_coyote_jump():
	velocity.x = physicsComponent.velocityX
	velocity.y = physicsComponent.velocityY
	var wasOnFloor = is_on_floor()
	move_and_slide()
	justLeftLedge = wasOnFloor and not is_on_floor() and velocity.y >= 0
	
