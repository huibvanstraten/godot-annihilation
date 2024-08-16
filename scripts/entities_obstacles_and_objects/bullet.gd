class_name Bullet
extends Node2D

@export var speed: float
@export var direction: float
@export var acceleration: float
@export var spawnPosition: Vector2

@export var animationPlayer: AnimationPlayer = null

func _ready():
	animationPlayer.play("fly")
	EventManager.remove_attack_body.connect(_on_remove_attack_body)
	
func _process(delta):
	position.x += direction * speed * delta

	if is_out_of_bounds():
		queue_free()

func is_out_of_bounds() -> bool:
	return global_position.x < spawnPosition.x - 1000 or global_position.x > spawnPosition.x + 3000

func _on_remove_attack_body(attackBody: Node2D):
	if attackBody == self:
		speed = 0
		animationPlayer.play("explode")

func _on_animation_player_animation_finished(animName):
	if animName == "explode":
		queue_free()
