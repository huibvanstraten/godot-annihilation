class_name Level
extends Node

@export var levelId: int
@export var pixelformat: bool

var levelData: LevelData

var currentArea: Node2D = null

func _ready():
	levelData = LevelManager.get_level_data_by_id(levelId)
	loadArea(levelData.areas[0].areaPath)
	
	EventManager.connect("player_died", _on_player_died)
	EventManager.connect("game_paused", _on_game_paused)
	EventManager.transition_to_area.connect(loadArea)
		
	MusicManager._get_all_songs()

func loadArea(areaPath: String):
	if currentArea:
		currentArea.call_deferred("queue_free")

	var areaNode = load(areaPath)
	var areaInstance = areaNode.instantiate()
	currentArea = areaInstance
	call_deferred("add_child", areaInstance)

func _process(_delta):
	if Input.is_action_just_pressed("play_song"):
		MusicManager.play_song_from_list()
	
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

func _on_player_died():
	call_deferred("loadArea", levelData.areas[0].areaPath)

func _on_game_paused(isPaused: bool):
	get_tree().paused = isPaused
