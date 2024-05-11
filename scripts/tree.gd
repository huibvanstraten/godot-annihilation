extends Node2D

signal tree_animation_finished

@onready var animated_sprite = $AnimatedSprite2D

func play_animation():
	animated_sprite.play("flying")



func _on_animated_sprite_2d_animation_finished():
	emit_signal("tree_animation_finished")
