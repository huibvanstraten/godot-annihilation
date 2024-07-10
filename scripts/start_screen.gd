class_name MainMenu
extends Node2D

var start_menu_select = preload("res://scenes/menus/main_menu_select.tscn")
var start_menu = null

func _ready():
	start_menu = start_menu_select.instantiate()
	add_child(start_menu)
	EventManager.connect("level", load_level)

func load_level(levelId: int):
	LevelManager.load_level(levelId)
	_deactivate()

func _deactivate():
	hide()
	set_process(false)
	set_process_input(false)
	set_physics_process(false)
	set_process_unhandled_input(false)
	queue_free()
