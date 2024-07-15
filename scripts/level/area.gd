class_name Area
extends Node

@onready var areaBoundaries: Node2D = $AreaBoundaries
@onready var startPosition: Marker2D = $StartPosition

var areaData: AreaData

func _ready():
	PlayerManager.spawn_player(startPosition.global_position, true)
