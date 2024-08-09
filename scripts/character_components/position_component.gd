class_name PositionComponent
extends Node2D

var standingPositions: Array[Marker2D]
var currentPosition: Marker2D = null
var nextPosition: Marker2D

func _ready():
	EventManager.pass_positions.connect(get_standing_positions)
	EventManager.get_positions.emit()

func select_random_position():
	nextPosition = standingPositions.pick_random()
	currentPosition = nextPosition
	print("random" + str(currentPosition))

func select_position():
	if nextPosition == null:
		currentPosition = standingPositions[1]
	var filteredPositions = standingPositions.filter(func(item):
		return item != currentPosition
	)
	
	nextPosition = filteredPositions[0]
	currentPosition = nextPosition
	print("select" + str(currentPosition))

func get_standing_positions(positions: Array):
	for marker in positions:
		standingPositions.append(marker as Marker2D)
