class_name Inventory
extends Resource

signal inventory_updated(entity: Node2D)

enum InventoryType { ItemType, BuddyType, AnyType }

@export var inventoryName: String
@export var inventoryType: InventoryType
@export var collectables: Array[CollectableResource]

func insert(collectable: CollectableResource):
	if inventoryType == collectable.type or inventoryType == InventoryType.AnyType:
		print(collectables.size())
		for i in range(collectables.size()):
			if !collectables[i]:
				print()
				collectable.active = true
				collectables[i] = collectable
				break
		
	emit_signal("inventory_updated")

func get_filled_collectables_amount():
	var count = 0
	for collectable in collectables:
		if collectable:
			count += 1
	
	return count
	
func remove(index: int):
	collectables[index] = null
	_rearrange_slots()
	emit_signal("inventory_updated")
	
func _rearrange_slots():
	var sortedArray: Array[CollectableResource]
	print(collectables.size())
	for i in range(collectables.size()):
		if collectables[i]:
			print(collectables[i].name)
			sortedArray.append(collectables[i])
			print(sortedArray[0].name)
	print(sortedArray.size())
	print(collectables.size() - sortedArray.size())
	for i in (collectables.size() - sortedArray.size()):
		print("appending")
		sortedArray.append(null)
	print(sortedArray.size())
	collectables = sortedArray
