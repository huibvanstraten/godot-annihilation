class_name BossArea
extends Area

var mushroomSpawnMarkers: Array
var bossStandingMarkers: Array

func _ready():
	mushroomSpawnMarkers = get_node("MushroomSpawnMarkers").get_children()
	bossStandingMarkers = get_node("BossStandingPoints").get_children()
	EventManager.grow_mushrooms.connect(_on_grow_mushrooms)
	EventManager.get_positions.connect(_on_get_positions)

func _on_grow_mushrooms():
	for marker in mushroomSpawnMarkers:
		var mushroom = preload("res://scenes/levels/attributes/obstacles/paralyzing_mushroom_boss.tscn").instantiate()
		mushroom.global_position = (marker as Marker2D).global_position
		get_tree().root.add_child.call_deferred(mushroom)	

func _on_get_positions():
	EventManager.pass_positions.emit(bossStandingMarkers)
