class_name Boss
extends Entity

@export var attackComponent: AttackComponent = null
@export var wanderComponent: BossWalkComponent = null
@export var jumpComponent: BossJumpComponent = null
@export var dashComponent: DashComponent = null
@export var collisionShape: CollisionShape2D = null 
@export var positionComponent: PositionComponent = null
@export var rayCast: RayCast2D = null

var defaultRayCastPosition: float

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	defaultRayCastPosition = rayCast.position.x * -1
	
func _physics_process(delta):

	if not is_on_floor():
		physicsComponent.set_velocity(delta)
		physicsComponent.move_in_air(sign(physicsComponent.facingDirection))
		flipComponent.flip()

	if stateMachine.currentState is BossIdleState:
		physicsComponent.velocityX = 0.0

	if stateMachine.currentState is BossWalkState:
		var targetPosition = positionComponent.nextPosition.global_position
		var positionToTravel = (targetPosition - global_position)
		wanderComponent.walkTo(positionToTravel)
		flipComponent.flip()
		
		if global_position.distance_to(targetPosition) < 45.0:
			wanderComponent.stop_wander(delta)
			EventManager.position_reached.emit(stateMachine.currentState.stateName)
	
	if stateMachine.currentState is BossJumpState:
		var targetPosition = positionComponent.nextPosition.global_position
		var positionToTravel = (targetPosition - global_position)
		jumpComponent.jump_to(positionToTravel)
		physicsComponent.direction.x = sign(positionToTravel.x)
		flipComponent.flip()
		var targetReachedTolerance
		if positionToTravel.x < 0:
			targetReachedTolerance = -5.0
			if positionToTravel.x > targetReachedTolerance:
				physicsComponent.direction.x = sign(positionToTravel.x) * -1
				flipComponent.flip()
				jumpComponent.get_to_target()
		else:
			targetReachedTolerance = 5.0
			if positionToTravel.x < targetReachedTolerance:
				physicsComponent.direction.x = sign(positionToTravel.x) * -1
				flipComponent.flip()
				jumpComponent.get_to_target()
				
		if global_position.distance_to(targetPosition) < 13.0:
			EventManager.position_reached.emit(stateMachine.currentState.stateName)


	if stateMachine.currentState is BossDashState:
		var targetPosition = positionComponent.nextPosition.global_position
		var positionToTravel = (targetPosition - global_position)
		physicsComponent.direction.x = sign(positionToTravel.x)
		dashComponent.dash_to(positionToTravel)
		flipComponent.flip()
		if global_position.distance_to(targetPosition) < 45.0:
			physicsComponent.stop(delta)
			EventManager.position_reached.emit(stateMachine.currentState.stateName)
	
	if stateMachine.currentState is BossAttackState and attackComponent.player != null:
		var playerPosition = attackComponent.get_target_position()
		var positionToTravel = (playerPosition - position).normalized()
		attackComponent.attack(positionToTravel)
		flipComponent.flip()
	
	velocity.x = physicsComponent.velocityX
	velocity.y = physicsComponent.velocityY
	move_and_slide()
