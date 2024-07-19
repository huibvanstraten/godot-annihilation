class_name AttackBodyComponent
extends Area2D

@export var attackBodyShape: CollisionShape2D = null
@export var pathFollow: PathFollow2D = null

@export var damage: float = 10.0
@export var direction_left: Vector2 = Vector2(-1, 0)
@export var direction_right: Vector2 = Vector2(1, 0)

@export var removeBodyAtTouch: bool = false
@export var removeAttackBodyAtTouch: bool = false

@export var attackBodyPosition: float = 0

func _ready():
	self.connect("body_entered", _on_bullet_entered)
	self.connect("area_entered", _on_bullet_entered)

func _on_bullet_entered(body):
	if removeAttackBodyAtTouch:
		EventManager.emit_signal("remove_attack_body")
	
	if body is CharacterBody2D:
		for child in body.find_child("Components").get_children():
			if child is HealthComponent:
				child.hit(damage)
				
			if child is PhysicsComponent:
				var parentGlobalPosition = get_global_position_parent_body()
				var direction_to_body = sign(body.global_position.x - parentGlobalPosition)
				var knockback_direction = direction_to_body
				child.set_knockback_direction(knockback_direction)

func get_global_position_parent_body() -> float:
	if pathFollow == null:
		return get_parent().global_position.x
	else:
		return pathFollow.global_position.x
