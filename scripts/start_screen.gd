class_name MainMenu
extends Node2D

var start_menu_select = preload("res://scenes/menus/main_menu_select.tscn")
var start_menu = null

func _ready():
	start_menu = start_menu_select.instantiate()
	add_child(start_menu)
	start_menu.connect("new_game", _new_game)
	start_menu.connect("continue_game", _continue_game)

func _new_game(): 
	print("choose new game")
	_deactivate()
	LevelManager.load_level(1)
	
	
func _continue_game():
	SaverLoader.load_game()

func _deactivate():
	hide()
	set_process(false)
	set_process_input(false)
	set_physics_process(false)
	set_process_unhandled_input(false)
	queue_free()
