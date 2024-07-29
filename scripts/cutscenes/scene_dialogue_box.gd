extends Node2D

@onready var animationPlayer: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	animationPlayer.play("write_text")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
