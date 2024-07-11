class_name Inventory
extends Resource

signal inventory_updated

@export var inventoryName: String
@export var items: Array[InventoryItem]

func insert(item: InventoryItem):
	for i in range(items.size()):
		if !items[i]:
			items[i] = item
			break
		
	emit_signal("inventory_updated")
