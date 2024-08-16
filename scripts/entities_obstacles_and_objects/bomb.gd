class_name Bomb
extends Node2D

@export var speed: float
@export var direction: Vector2
@export var acceleration: float

@export var animationPlayer: AnimationPlayer = null

func _ready():
	animationPlayer.play("fly")
	EventManager.remove_attack_body.connect(_on_remove_attack_body)
	
func _process(delta):
	position += direction * speed * delta

func _on_remove_attack_body(attackBody: Node2D):
	if attackBody == self:
		speed = 0
		animationPlayer.play("explode")

func _on_animation_player_animation_finished(animName):
	if animName == "explode":
		queue_free()
