extends Node2D

@onready var animationPlayer: AnimationPlayer = $AnimationPlayer


func _ready():
	animationPlayer.play("city")



func _process(delta):
	pass
