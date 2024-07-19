class_name Main
extends Node

@export var availableLevels: Array[LevelData]

@onready var levelContainer = $LevelContainer

func _ready():
	LevelManager.mainScene = levelContainer
	LevelManager.levels = availableLevels
	MusicManager.stream = load("res://assets/audio/music/Extinction full.wav")
	MusicManager.play()
	
	InputMapManager.load_input_mapping("res://input_map/input_config_8bitdo_pro2.json")
