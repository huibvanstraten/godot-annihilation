class_name ParalyzingMushroomBoss
extends Node2D

@export var animationPlayer: AnimationPlayer = null

@onready var explodeTimer: Timer = $Timer

func _ready():
	animationPlayer.play("grow")
	
func _on_grow_timer_timeout():
	explode()

func _on_animation_player_animation_finished(animName):
	if animName == "grow":
		animationPlayer.play("idle")
		explodeTimer.start(10)
	elif animName == "explode":
		queue_free()

func _on_idle_body_body_entered(body):
	if body is Player:
		explode()

func explode():
	animationPlayer.play("explode")
