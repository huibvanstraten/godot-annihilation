class_name Item
extends Area2D

@export var itemResource: InventoryItem

func collect(inventory: Inventory):
	# can add 
	inventory.insert(itemResource)
	queue_free()

func _on_body_entered(body):
	if body is Player:
		var inventory = (body as Player).get_inventory()
		collect(inventory)
