class_name MushroomComponent
extends Node2D

@onready var explodeTimer: Timer = $Timer

var areMushroomsGrown: bool = false
var isPlayerParalyzed: bool = false

func _ready():
	EventManager.mushrooms_grown.connect(_on_mushrooms_grown)
	EventManager.player_paralyzed.connect(_on_player_paralyzed)

func grow_mushrooms():
	EventManager.grow_mushrooms.emit()
	explodeTimer.start()

func _on_mushrooms_grown():
	if !areMushroomsGrown:
		areMushroomsGrown = true
		
func _on_player_paralyzed():
	isPlayerParalyzed = true
	explode_all_mushrooms()
	
func _on_timer_timeout():
	explode_all_mushrooms()
	
func explode_all_mushrooms():
	EventManager.explode_mushrooms.emit()
	await get_tree().create_timer(3.0).timeout
	isPlayerParalyzed = true

func remove_all_mushrooms():
	EventManager.remove_mushrooms.emit()
	explodeTimer.stop()
