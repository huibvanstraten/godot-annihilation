class_name NPC
extends Entity

@onready var animation: AnimationPlayer = $AnimatedSprite2D/AnimationPlayer

func _ready():
 animation.play("idle")
