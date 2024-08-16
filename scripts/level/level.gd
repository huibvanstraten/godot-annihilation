class_name Level
extends Node

@export var levelId: int
@export var startPosition: Marker2D = null

var levelData: LevelData
var player: Player
var currentAreaId: int

func _ready():
	run_scene_on_screen()
	#InputMapManager.load_input_mapping("res://input_map/input_config_8bitdo_pro2.json")
	
	levelData = LevelManager.get_level_data_by_id(levelId)
	set_current_area(5)
	
	EventManager.connect("player_died", _on_player_died)
	EventManager.connect("game_paused", _on_game_paused)
	EventManager.transition_to_area.connect(set_current_area)
	
	player = PlayerManager.spawn_player(startPosition.global_position)
	
	MusicManager.stop()
	MusicManager._get_all_songs()

func set_current_area(areaId: int):
	currentAreaId = areaId

func _process(_delta):
	if Input.is_action_just_pressed("play_song"):
		MusicManager.play_song_from_list()
	
	if Input.is_action_just_pressed("quit"):
		get_tree().change_scene_to_file("res://scenes/main.tscn")
		MusicManager.stop()

func _on_player_died():
	PlayerManager.spawn_player(startPosition.global_position)
	EventManager.transition_to_area.emit(1)

func _on_game_paused(isPaused: bool):
	get_tree().paused = isPaused

func run_scene_on_screen():
	var target_screen = 2  # Set this to the index of your desired screen
	if target_screen < DisplayServer.get_screen_count():
		# Move the window to the target screen
		DisplayServer.window_set_current_screen(target_screen)
		
		# Optional: Adjust the window size to match the target screen's resolution
		var screen_size = DisplayServer.screen_get_size(target_screen)
		DisplayServer.window_set_size(screen_size)
		
		# Optionally, center the window on the target screen
		DisplayServer.window_set_position(Vector2(0, 0))
	else:
		print("Target screen index out of range")
