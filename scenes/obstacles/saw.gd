class_name Saw
extends Node2D

@export var animationPlayer: AnimationPlayer = null

# Called when the node enters the scene tree for the first time.
func _ready():
	animationPlayer.play("spin")
