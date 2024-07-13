class_name Inventory
extends Resource

signal inventory_updated(entity: Node2D)

@export var inventoryName: String
@export var collectables: Array[CollectableResource]

func insert(collectable: CollectableResource):
	for i in range(collectables.size()):
		if !collectables[i]:
			collectables[i] = collectable
			break
		
	emit_signal("inventory_updated")
