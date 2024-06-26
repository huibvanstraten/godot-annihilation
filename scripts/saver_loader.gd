extends Node2D

const SAVE_FILE_PATH = "user://savegame.tres"

func save_game():
	var saved_game: SavedGame = SavedGame.new() 
	var saved_data: Array[SavedData] = []
	get_tree().call_group("game_events", "on_save_game", saved_data)
	
	ResourceSaver.save(saved_game, SAVE_FILE_PATH)

func load_game():
	print("load func")
	var saved_game: SavedGame = load(SAVE_FILE_PATH) as SavedGame
	
	for item in saved_game.saved_data:
		var scene = load(item.scene_path) as PackedScene
		var scene_instance = scene.instantiate()
		
		if scene_instance.has_method("on_load_game"):
			scene_instance.on_load_game(item)
