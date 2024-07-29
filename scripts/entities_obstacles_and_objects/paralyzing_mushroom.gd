class_name ParalyzingMushroom
extends Node2D

@export var animationPlayer: AnimationPlayer = null

@onready var growTimer: Timer = $GrowTimer

func _ready():
	animationPlayer.play("idle")
	
func regrow():
	animationPlayer.play("grow")

func _on_grow_timer_timeout():
	regrow()


func _on_animation_player_animation_finished(animName):
	if animName == "grow":
		animationPlayer.play("idle")
	elif animName == "explode":
		growTimer.start()
		
func _on_idle_body_body_entered(body):
	if body is Player:
		animationPlayer.play("explode")
