class_name BossArea
extends Area

var mushroomSpawnMarkers

func _ready():
	EventManager.grow_mushrooms.connect(_on_grow_mushrooms)
	mushroomSpawnMarkers = get_node("MushroomSpawnMarkers").get_children()

func _on_grow_mushrooms():
	for marker in mushroomSpawnMarkers:
		var mushroom = preload("res://scenes/levels/attributes/obstacles/paralyzing_mushroom_boss.tscn").instantiate()
		mushroom.global_position = (marker as Marker2D).global_position
		get_tree().root.add_child.call_deferred(mushroom)	
