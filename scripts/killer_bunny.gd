extends Node2D

signal animation_done

@onready var animation_player = $AnimationPlayer

func _ready():
	animation_player.play("FadeIn")

func play_animation():
	animation_player.play("FadeOut")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "FadeOut":
		emit_signal("animation_done")
