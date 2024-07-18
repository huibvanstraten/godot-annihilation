class_name Main
extends Node

@export var availableLevels: Array[LevelData]

@onready var levelContainer = $LevelContainer

func _ready():
	LevelManager.mainScene = levelContainer
	LevelManager.levels = availableLevels
	MusicManager.stream = load("res://assets/audio/music/Extinction full.wav")
	MusicManager.play()
	
	load_input_mapping("res://input_map/input_config_8bitdo_pro2.json")


func load_input_mapping(file_path: String) -> void:
	var file = FileAccess.open(file_path, FileAccess.READ)
	if not file:
		print("Error opening file:", file_path)
		return

	var json_text = file.get_as_text()
	file.close()

	var json = JSON.new()
	var error = json.parse(json_text)
	if error != OK:
		print("Error parsing JSON file:", json.get_error_message())
		return

	var config = json.data
	if not config.has_all(["ui_accept", "move_right", "move_left", "jump", "quit",
						   "start", "move_down", "move_up", "kick", "interact",
						   "enter", "wall cling", "shoot", "play_song", "crouch",
						   "pause", "select"]):
		print("Error: Missing action keys in input mapping configuration.")
		return

	# Clear existing actions
	#var actions = InputMap.get_actions()
	#for action in actions:
		#InputMap.erase_action(action)

	# Add new actions from the configuration file
	for action_name in config.keys():
		if action_name != "deadzone":
			InputMap.add_action(action_name)
			for event_dict in config[action_name]["events"]:
				var event = create_input_event(event_dict)
				InputMap.action_add_event(action_name, event)


func create_input_event(actionData: Dictionary) -> InputEvent:
	var event: InputEvent

	match actionData["type"]:
		"InputEventJoypadButton":
			event = InputEventJoypadButton.new()
			event.button_index = actionData["button_index"]
			event.pressed = actionData["pressed"]
			event.device = actionData["device"]
			event.resource_local_to_scene = actionData["resource_local_to_scene"]
			event.resource_name = actionData["resource_name"]
			event.pressure = actionData["pressure"]
			event.script = actionData["script"]

		"InputEventJoypadMotion":
			event = InputEventJoypadMotion.new()
			event.axis = actionData["axis"]
			event.axis_value = actionData["axis_value"]
			event.device = actionData["device"]
			event.resource_local_to_scene = actionData["resource_local_to_scene"]
			event.resource_name = actionData["resource_name"]
			event.script = actionData["script"]

		_:
			print("Unknown or unsupported input event type:", actionData["type"])
			event = InputEvent.new.call()

	return event

