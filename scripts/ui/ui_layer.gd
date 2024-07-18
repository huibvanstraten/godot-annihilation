class_name UiLayer
extends CanvasLayer

var inventoryNode = preload("res://scenes/UI/inventory_gui.tscn")
var inventory: Control

var levelPaused: bool = false

func _ready():
	inventory = inventoryNode.instantiate()
	add_child(inventory)

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		if !levelPaused:
			levelPaused = true
			inventory.open_inventory()
		else:
			levelPaused = false
			inventory.close_inventory()
