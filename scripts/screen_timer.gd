extends Node2D

@export var next_scene = ""

func _on_next_scene_timer_timeout():
	get_tree().change_scene_to_file(next_scene)
