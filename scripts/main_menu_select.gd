extends Control

signal new_game
signal continue_game

var current_button_index = 0

func _ready():
	get_node("VBoxContainer").get_child(current_button_index).grab_focus()

func _input(_event):
	if Input.is_action_just_pressed("move_down"):
		navigate_buttons(1)
	elif Input.is_action_just_pressed("move_up"):
		navigate_buttons(-1)

func navigate_buttons(direction):
	current_button_index += direction
	var buttons = get_node("VBoxContainer").get_children()
	print(buttons.size())
	print(buttons)
	current_button_index = clamp(current_button_index, 0, buttons.size() - 1)
	print(current_button_index)

	buttons[current_button_index].grab_focus()

func _on_start_pressed():
	emit_signal("new_game")

func _on_quit_pressed():
	get_tree().quit()

func _on_continue_pressed():
	print("CONTINUE")
