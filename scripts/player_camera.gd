class_name PlayerCamera
extends Camera2D

func _ready():
	set_camera_boundaries()

func set_camera_boundaries():
	var levelBoundaries: Array = LevelManager.get_level_boundaries()
	print("setting boundaries")
	limit_left = (levelBoundaries[0] as StaticBody2D).global_position.x
	limit_right = (levelBoundaries[1] as StaticBody2D).global_position.x
	limit_top = (levelBoundaries[2] as StaticBody2D).global_position.y
	limit_bottom = (levelBoundaries[3] as StaticBody2D).global_position.y
