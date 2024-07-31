class_name Slime
extends Entity

@export var jump_velocity: float = -200.0

@export var attackComponent: AttackComponent = null
@export var wanderComponent: WanderComponent = null
@export var collisionShape: CollisionShape2D = null 
@export var rayCast: RayCast2D = null

var defaultRayCastPosition: float

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	defaultRayCastPosition = rayCast.position.x * -1
	
func _physics_process(delta):
	if not is_on_floor():
		physicsComponent.set_velocity(delta)
	
	if stateMachine.currentState is EnemyHitState: 
		physicsComponent.knock_back()
		flipComponent.flip()
		
	if stateMachine.currentState is AttackingState and attackComponent.player != null:
		var playerPosition = attackComponent.get_target_position()
		var positionToTravel = (playerPosition - position).normalized()
		attackComponent.attack(positionToTravel, delta)
		flipComponent.flip()
	
	velocity.x = physicsComponent.velocityX
	velocity.y = physicsComponent.velocityY
	move_and_slide()
