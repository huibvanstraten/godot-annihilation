extends Node2D

var killer_bunny_scene = preload("res://scenes/killer_bunny.tscn")
var killer_bunny = null

func _ready():
	killer_bunny = killer_bunny_scene.instantiate()
	add_child(killer_bunny)
	killer_bunny.connect("animation_done", _change_scene)


func _input(_event):
	if Input.is_action_just_pressed("start"):
		killer_bunny.play_animation()

func _change_scene():
	get_tree().change_scene_to_file("res://scenes/start_screen.tscn")
