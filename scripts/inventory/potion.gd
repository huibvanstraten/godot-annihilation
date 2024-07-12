class_name Potion
extends Collectable

@onready var animationPlayer: AnimationPlayer = $AnimatedSprite2D/AnimationPlayer

@export var animationName: String 

func _ready():
	super()
	animationPlayer.play(animationName)
