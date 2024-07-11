class_name Player
extends Entity

@export var shootComponent: ShootComponent = null
@onready var jumpComponent: JumpComponent = $Components/Jump

@export var gunMarker: Marker2D = null
@export var rayCast: RayCast2D = null

@export var inventory: Inventory

var justLeftLedge: bool = false

var defaultRayCastPositionX: float

var playerFreeze: bool = false

func _ready():
	EventManager.connect("freeze_player", freeze)

func _physics_process(delta):
	var inputAxis = Input.get_axis("move_left", "move_right")
	var currentState = stateMachine.currentState
	bodyCollisionShape.rotation_degrees = physicsComponent.collisionRotation
	
	if jumpComponent.wallJump and currentState is FallState:
		jumpComponent.wallJump = false
	
	if currentState is DieState:
		physicsComponent.velocityX = 0

	if currentState is HitState: 
		physicsComponent.knock_back()
		
	if currentState is CrouchState or currentState is AttackState:
		physicsComponent.stop(delta)
	
	if not is_on_floor():
		physicsComponent.set_velocity(delta)
		
		if inputAxis != 0 and stateMachine.can_move():
			physicsComponent.move_in_air(delta, sign(inputAxis))
			flipComponent.flip()
		elif jumpComponent.wallJump:
			pass
		elif inputAxis == 0 and currentState != HitState:
			physicsComponent.air_resistance(delta)
	
	else:
		if inputAxis != 0 and stateMachine.can_move():
			physicsComponent.move(delta, sign(inputAxis))
			flipComponent.flip()
		elif inputAxis == 0 and currentState != HitState:
			physicsComponent.stop(delta)
	
	if not playerFreeze:
		move_and_slide_with_coyote_jump()

func move_and_slide_with_coyote_jump():
	velocity.x = physicsComponent.velocityX
	velocity.y = physicsComponent.velocityY
	var wasOnFloor = is_on_floor()
	move_and_slide()
	justLeftLedge = wasOnFloor and not is_on_floor() and velocity.y >= 0
	
func on_save_game(saved_data: Array[SavedData]):
	var my_data = SavedData.new()
	my_data.level_scene_path = scene_file_path
	
	saved_data.append(my_data)

func on_load_game(saved_data:SavedData):
	if saved_data is SavedPlayerData:
			pass

func freeze(shouldFreeze: bool):
	playerFreeze = shouldFreeze
	
func get_inventory() -> Inventory:
	return inventory
