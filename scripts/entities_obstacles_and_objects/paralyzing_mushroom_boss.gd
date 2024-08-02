class_name ParalyzingMushroomBoss
extends Node2D

@export var animationPlayer: AnimationPlayer = null

func _ready():
	animationPlayer.play("grow")
	EventManager.explode_mushrooms.connect(_on_explode_mushroom)
	EventManager.remove_mushrooms.connect(_on_remove_mushroom)
	
func _on_animation_player_animation_finished(animName):
	if animName == "grow":
		animationPlayer.play("idle")
		EventManager.mushrooms_grown.emit()
	elif animName == "explode":
		queue_free()

func _on_idle_body_body_entered(body):
	if body is Player:
		explode()

func explode():
	animationPlayer.play("explode")

func _on_explode_mushroom():
	explode()

func _on_remove_mushroom():
	queue_free()
