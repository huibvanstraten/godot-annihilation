extends Node2D

var scene_changer = preload("res://scenes/scene_changer.tscn")
var scene_changer_instance = null

func _ready():
	scene_changer_instance = scene_changer.instantiate()
	scene_changer_instance.next_scene = "res://scenes/intro.tscn"
	add_child(scene_changer_instance)
	
func _input(_event):
	if Input.is_action_just_pressed("start"):
		scene_changer_instance._change_scene()
