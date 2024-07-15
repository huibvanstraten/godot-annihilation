extends Node2D

var levels: Array[LevelData]

var mainScene: Node2D = null
var loadedLevel: Level = null

func unload_level():
	if is_instance_valid(loadedLevel):
		loadedLevel.queue_free()
		
	loadedLevel = null
	
func load_level(levelId: int):
	print("loading level: %s" % levelId)
	unload_level()
	
	var levelData = get_level_data_by_id(levelId)
	
	if not levelData:
		push_error("no level available")
		return
		
	var levelPath = "res://scenes/%s.tscn" % levelData.levelPath
	var levelRes = load(levelPath)
	
	if levelRes:
		loadedLevel = levelRes.instantiate()
		mainScene.add_child(loadedLevel)

func get_level_data_by_id(levelId: int) -> LevelData:
	var levelToReturn: LevelData = null
	
	for level in levels:
		if level.levelId == levelId:
			levelToReturn = level
	
	return levelToReturn
		
func get_current_level():
	return loadedLevel

func get_level_boundaries() -> Array[StaticBody2D]:
	var level = get_current_level()
	print("checcccck")
	print(level)
	print(level.currentArea)
	var area = level.currentArea as Area
	var boundaries: Array[StaticBody2D] 
	for i in area.areaBoundaries.get_children():
		boundaries.append(i as StaticBody2D)
	return boundaries
