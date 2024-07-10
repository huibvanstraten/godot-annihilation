class_name Level
extends Node

@export var levelId: int
@export var startPosition: Marker2D = null
@export var pixelformat: bool

var levelData: LevelData

func _ready():
	levelData = LevelManager.get_level_data_by_id(levelId)
	EventManager.connect("player_died", _on_player_died)
	PlayerManager.spawn_player(startPosition.global_position, pixelformat)
	MusicManager._get_all_songs()

func _process(_delta):
	if Input.is_action_just_pressed("play_song"):
		MusicManager.play_song_from_list()
	
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

func start_level():
	get_tree().reload_current_scene()

func _on_player_died():
	PlayerManager.spawn_player(startPosition.global_position, pixelformat)
