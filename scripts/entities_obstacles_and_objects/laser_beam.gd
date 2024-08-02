class_name LaserBeam
extends Node2D

const MAX_LENGTH = 2000

signal remove_laser

@onready var laser: Line2D = $RayCast2D/Laser
@onready var end: Node2D = $RayCast2D/End
@onready var rayCast: RayCast2D = $RayCast2D
@onready var attackBody: CollisionShape2D = $RayCast2D/Area2D/AttackBody

@export var speed: float = 2

var direction: int = 1
var startPoint: Vector2
var endPoint: Vector2
var currentAngle: float

func _ready():
	set_target_angles()
	currentAngle = startPoint.angle()

func _process(delta):
	shoot(delta)

func shoot(delta: float):
	currentAngle += speed * delta * direction
	if direction == 1 and currentAngle >= endPoint.angle():
		currentAngle = endPoint.angle()
		remove_laser.emit()
	elif direction == -1 and currentAngle <= endPoint.angle():
		currentAngle = endPoint.angle()
		remove_laser.emit()

	var target = Vector2.from_angle(currentAngle)
	laser_move_and_collide(target)

# TODO: laser collision point. figure out angle
func laser_move_and_collide(target: Vector2):
	var maxCastTo = target.normalized() * MAX_LENGTH
	rayCast.target_position = maxCastTo
	
	if rayCast.is_colliding():
		var collisionPoint = to_local(rayCast.get_collision_point())
		laser.points[1] = collisionPoint
		end.position = collisionPoint
		end.rotation = collisionPoint.angle()
		
		var collider = rayCast.get_collider()
		if collider.is_in_group("Player"):
			remove_laser.emit()
		
	else: 
		laser.points[1] = rayCast.target_position
		end.position = rayCast.target_position
		end.rotation = rayCast.target_position.angle()
	
	attackBody.position = laser.points[1] /2
	attackBody.shape.extents = Vector2(2, laser.points[1].length() / 2)

func set_target_angles(): 
	var startAngleDegrees = 180 
	var endAngleDegrees = -30
	
	if direction == -1:
		startAngleDegrees = 200
		endAngleDegrees = 330

	#startPoint = Vector2.from_angle(deg_to_rad(startAngleDegrees))
	#endPoint = Vector2.from_angle(deg_to_rad(endAngleDegrees))
	if direction == 1:
		startPoint = Vector2(100, -80)
		endPoint = Vector2(100, 80)
	else: 
		startPoint = Vector2(-100, -80)
		endPoint = Vector2(-40, 80)
