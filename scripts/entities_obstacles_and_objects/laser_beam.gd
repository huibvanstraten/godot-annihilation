extends Node2D

const MAX_LENGTH = 2000

@onready var laser: Line2D = $RayCast2D/Laser
@onready var end: Node2D = $RayCast2D/End
@onready var rayCast: RayCast2D = $RayCast2D
@onready var attackBody: Area2D = $RayCast2D/Area2D

func _process(_delta):
	shoot()

# TODO: get targetPosition and collisionshape should move along and grow with length
func shoot():
	var target = get_local_mouse_position()
	var maxCastTo = target.normalized() * MAX_LENGTH
	
	rayCast.target_position = maxCastTo
	
	if rayCast.is_colliding():
		var collisionPoint = to_local(rayCast.get_collision_point())
		laser.points[1] = collisionPoint
		end.position = collisionPoint
		end.rotation = collisionPoint.angle()
		
	else: 
		laser.points[1] = rayCast.target_position
		end.position = rayCast.target_position
		end.rotation = rayCast.target_position.angle()
		attackBody.rotation = rayCast.target_position.angle()
