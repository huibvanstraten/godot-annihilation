class_name Level
extends Node

@export var level_id: int
@export var start_position: Marker2D = null

var level_data: LevelData

func _ready():
	level_data = LevelManager.get_level_data_by_id(level_id)
	EventManager.connect("player_died", _on_player_died)
	PlayerManager.spawn_player(start_position.global_position)

func _on_player_died():
	PlayerManager.spawn_player(start_position.global_position)

func _process(_delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
