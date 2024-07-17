class_name Plant
extends Node2D

@export var attackSpeed: float = 50

@onready var animationPlayer: AnimationPlayer = $Area2D/AnimatedSprite2D/AnimationPlayer
@onready var attackComponent: AttackComponent = $Components/Attack

var animationFinished: bool = false

func _ready():
	animationPlayer.play("move")

func _process(_delta):
	if attackComponent.playerInRange and attackComponent.player != null and not animationFinished:
		animationPlayer.play("attack")
		animationFinished = false
	elif not attackComponent.playerInRange and animationFinished:
		animationPlayer.play("move")
		animationFinished = false


func _on_animation_player_animation_finished(_animName):
	animationFinished = true
