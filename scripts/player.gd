class_name Player
extends Entity

@export var shootComponent: ShootComponent = null

@export var gunMarker: Marker2D = null
@export var rayCast: RayCast2D = null

var justLeftLedge: bool = false

var defaultRayCastPositionX: float

#func _ready():
	#defaultRayCastPositionX = rayCast.position.x

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
	bodyCollisionShape.rotation_degrees = physicsComponent.collisionRotation
	bodyCollisionShape.scale.y = physicsComponent.collisionSizeY
	
	if currentState is DieState:
		physicsComponent.velocityX = 0

	if currentState is HitState: 
		physicsComponent.knock_back()
		
	if currentState is CrouchState or currentState is AttackState:
		physicsComponent.stop(delta)
	
	if not is_on_floor():
		physicsComponent.set_velocity(delta)
		
		if inputAxis != 0 and stateMachine.can_move():
			physicsComponent.move_in_air(delta, inputAxis)
			flipComponent.flip()
		elif inputAxis == 0 and currentState != HitState:
			physicsComponent.air_resistance(delta)
	
	else:
		if inputAxis != 0 and stateMachine.can_move():
			physicsComponent.move(delta, inputAxis)
			flipComponent.flip()
		elif inputAxis == 0 and currentState != HitState:
			physicsComponent.stop(delta)
		
	move_and_slide_with_coyote_jump()

func move_and_slide_with_coyote_jump():
	velocity.x = physicsComponent.velocityX
	velocity.y = physicsComponent.velocityY
	var wasOnFloor = is_on_floor()
	move_and_slide()
	justLeftLedge = wasOnFloor and not is_on_floor() and velocity.y >= 0
