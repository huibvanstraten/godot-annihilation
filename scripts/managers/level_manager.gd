extends Node2D

var levels: Array[LevelData]

var main_scene: Node2D = null
var loaded_level: Level = null

func unload_level():
	if is_instance_valid(loaded_level):
		loaded_level.queue_free()
		
	loaded_level = null
	
func load_level(level_id: int):
	print("loading level: %s" % level_id)
	unload_level()
	
	var level_data = get_level_data_by_id(level_id)
	
	if not level_data:
		push_error("no level available")
		return
		
	var level_path = "res://scenes/%s.tscn" % level_data.level_path
	var level_res = load(level_path)
	
	if level_res:
		loaded_level = level_res.instantiate()
		main_scene.add_child(loaded_level)

func get_level_data_by_id(level_id: int) -> LevelData:
	var level_to_return: LevelData = null
	
	for lvl in levels:
		if lvl.level_id == level_id:
			level_to_return = lvl
	
	return level_to_return
		
func get_current_level():
	return get_tree().current_scene
