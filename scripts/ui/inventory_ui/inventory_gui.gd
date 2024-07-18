class_name InventoryGui
extends Control

@onready var items: GridContainer = $NinePatchRect/Items
@onready var buddies: GridContainer = $NinePatchRect/Buddies
@onready var itemInventory: Inventory = preload("res://scripts/inventory/inventory_resources/player_item_inventory.tres")
@onready var buddyInventory: Inventory = preload("res://scripts/inventory/inventory_resources/player_buddy_inventory.tres")
@onready var itemSlots: Array = $NinePatchRect/Items.get_children()
@onready var buddySlots: Array = $NinePatchRect/Buddies.get_children()

var currentIndex: int = 0
var currentContainer: GridContainer

func _ready():
	buddyInventory.connect("inventory_updated", update_inventory_gui)
	itemInventory.connect("inventory_updated", update_inventory_gui)
	currentContainer = items
	hide()
	set_process_input(false)
	
func _input(event):
	if event.is_action_pressed("select"):
		_move_container_focus()
	elif event.is_action_pressed("move_left"):
		_move_focus(Vector2(-1, 0))
	elif event.is_action_pressed("move_right"):
		_move_focus(Vector2(1, 0))
	elif event.is_action_pressed("interact"):
		activate_collectable()

func _move_container_focus():
	print(currentContainer.name)
	remove_focus()
	if currentContainer.name == "Items":
		set_focus(buddies.get_child(0))
		currentContainer = buddies
	else:
		set_focus(items.get_child(0))
		currentContainer = items
	currentIndex = 0

func _move_focus(direction: Vector2):
	var newIndex = currentIndex
	if direction.x != 0:
		newIndex += int(direction.x)
	
	if newIndex >= 0 and newIndex < get_filled_slots_amount(currentContainer.get_children()):
		currentIndex = newIndex
		set_focus(currentContainer.get_child(currentIndex))

func set_focus(currentSlot: Panel):
	for i in get_filled_slots_amount(currentContainer.get_children()):
		var slot = currentContainer.get_child(i)
		slot.set_sprite_frame(false)
		
	currentSlot.set_sprite_frame(true)
	currentSlot.grab_focus()

func remove_focus():
	for i in get_filled_slots_amount(currentContainer.get_children()):
		var slot = currentContainer.get_child(i)
		(slot as Panel).set_sprite_frame(false)

func activate_collectable():
	var inventory: Inventory
	if currentContainer.name == "Items":
		inventory = itemInventory
	else:
		inventory = buddyInventory
	
	var collectable: CollectableResource = inventory.collectables[currentIndex]
	if collectable:
		EventManager.emit_signal("activate_collectable", collectable)
	inventory.remove(currentIndex)

func update_inventory_gui():
	var itemSlotAmount = min(itemInventory.collectables.size(), itemSlots.size())
	for i in range(itemSlotAmount):
		itemSlots[i].update(itemInventory.collectables[i])
	
	var buddySlotAmount = min(buddyInventory.collectables.size(), buddySlots.size())
	for i in range(buddySlotAmount):
			buddySlots[i].update(buddyInventory.collectables[i])

func open_inventory():
	show()
	EventManager.emit_signal("game_paused", true)
	set_process_input(true)
	update_inventory_gui()
	MusicManager.volume_db = MusicManager.volume_db - 20
	currentContainer = items
	set_focus(items.get_child(0))
	
func close_inventory():
	hide()
	EventManager.emit_signal("game_paused", false)
	set_process_input(false)
	currentIndex = 0
	MusicManager.volume_db = MusicManager.volume_db + 20
	remove_focus()

func get_filled_slots_amount(slots: Array) -> int:
	var count = 0
	for slot in slots:
		if (slot as InventoryPanel).hasItem:
			count += 1
	return count
