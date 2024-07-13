class_name InventoryGui
extends Control

@onready var gridContainer: GridContainer = $NinePatchRect/GridContainer
@onready var inventory: Inventory = preload("res://scripts/inventory/player_inventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()


var slotAmount: int = 0
var filledSlots: int = 0

var currentIndex = 0

func _ready():
	inventory.connect("inventory_updated", update_inventory)
	hide()
	set_process_input(false)
	
func _input(event):
	if event.is_action_pressed("move_left"):
		_move_focus(Vector2(-1, 0))
	elif event.is_action_pressed("move_right"):
		_move_focus(Vector2(1, 0))
	elif event.is_action_pressed("interact"):
		activate_collectable()

func _move_focus(direction: Vector2):
	var newIndex = currentIndex
	if direction.x != 0:
		newIndex += int(direction.x)
	
	if newIndex >= 0 and newIndex < filledSlots:
		currentIndex = newIndex
		set_focus(gridContainer.get_child(currentIndex))

func set_focus(currentSlot: Panel):
	for i in filledSlots:
		var slot = gridContainer.get_child(i)
		slot.set_sprite_frame(false)
		
	currentSlot.set_sprite_frame(true)
	currentSlot.grab_focus()

func activate_collectable():
	var collectable: CollectableResource = inventory.collectables[currentIndex]
	if not collectable.active:
		collectable.active = true
		EventManager.emit_signal("activate_collectable", collectable)
	inventory.collectables.remove_at(currentIndex)

func update_inventory(entity: Node2D = null):
	if not entity is Buddy:
		slotAmount = min(inventory.collectables.size(), slots.size())
		var count = 0
		for i in range(slotAmount):
			count += slots[i].update(inventory.collectables[i])
		filledSlots = count
		
		set_focus(gridContainer.get_child(0))

func open_inventory():
	show()
	EventManager.emit_signal("game_paused", true)
	set_process_input(true)
	update_inventory()
	
func close_inventory():
	hide()
	EventManager.emit_signal("game_paused", false)
	set_process_input(false)
	currentIndex = 0
