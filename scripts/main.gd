extends Node

@export var available_levels: Array[LevelData]

@onready var level_container = $LevelContainer

func _ready():
	LevelManager.mainScene = level_container
	LevelManager.levels = available_levels