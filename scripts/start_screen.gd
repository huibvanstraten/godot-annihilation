extends Node2D

var tree_scene = preload("res://scenes/tree.tscn")
var tree = null

func _ready():
	tree = tree_scene.instantiate()
	add_child(tree)
	tree.connect("tree_animation_finished", _change_scene)

func _input(_event):
	if Input.is_action_just_pressed("start"):
		tree.play_animation()

func _change_scene():
	get_tree().change_scene_to_file("res://scenes/level.tscn")
