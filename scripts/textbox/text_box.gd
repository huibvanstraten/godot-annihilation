extends CanvasLayer

var text_display_complete:bool = true

const CHAR_READ_RATE = 3.0

@onready var textbox_container = $TextboxContainer
@onready var start_symbol = $TextboxContainer/MarginContainer/HBoxContainer/Start
@onready var end_symbol = $TextboxContainer/MarginContainer/HBoxContainer/End
@onready var label = $TextboxContainer/MarginContainer/HBoxContainer/Label

@onready var level_manager = get_node("/root/LevelManager")

enum State {
	READY,
	READING,
	FINISHED
}

var current_state = State.READY
var text_queue = []

func _ready():
	hide_textbox()

func _process(_delta):
	match current_state:
		State.READY:
			if !text_queue.is_empty():
				change_state(State.READING)
				show_textbox()
		State.READING:
			display_text()
			if Input.is_action_just_pressed("interact"):
				text_display_complete = true
				display_text()
		State.FINISHED:
			if Input.is_action_just_pressed("interact"):
				change_state(State.READY)
				hide_textbox()

func queue_text(next_text):
	text_queue.push_back(next_text)

func hide_textbox():
	start_symbol.text = ""
	end_symbol.text = ""
	label.text = ""
	textbox_container.hide()

func show_textbox():
	start_symbol.text = "*"
	textbox_container.show()

func display_text():
	if !text_queue.is_empty() and text_display_complete:
		text_display_complete = false
		var next_text = text_queue.pop_front()
		label.text = next_text
		label.visible_ratio = 0.0
		var tween = create_tween()
		tween.tween_property(label, "visible_ratio", 1.0, CHAR_READ_RATE)
	elif text_queue.is_empty() and text_display_complete:
		change_state(State.FINISHED)

func change_state(next_state):
	current_state = next_state
	match current_state:
		State.READY:
			print("Changing state to: State.READY")
		State.READING:
			print("Changing state to: State.READING")
			_toggle_player_active(false)
		State.FINISHED:
			print("Changing state to: State.FINISHED")
			_toggle_player_active(true)

func _on_Tween_tween_completed(_object, _key):
	text_display_complete = true
	
func _toggle_player_active(is_active: bool):
	var player_instance = level_manager.get_player()
	print(player_instance)
	player_instance.toggle_player_active(is_active)

func _get_current_level():
	return get_tree().current_scene
