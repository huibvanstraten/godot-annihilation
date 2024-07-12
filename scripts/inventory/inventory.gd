class_name Inventory
extends Resource

signal inventory_updated(entity: Node2D)

@export var inventoryName: String
@export var items: Array[InventoryItem]

func insert(collectable: InventoryItem):
	for i in range(items.size()):
		if !items[i]:
			items[i] = collectable
			break
		
	emit_signal("inventory_updated")
