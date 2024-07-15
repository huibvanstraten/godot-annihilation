class_name Buddy
extends Area2D

@export var animationPlayer: AnimationPlayer = null
@export var flyComponent: FlyComponent = null

@export var inventory: Inventory

var spawnMarker: Marker2D = null

var isFlying: bool = false

var targetPosition: Vector2

func get_inventory() -> Inventory:
	return inventory
	
func _on_body_entered(body):
	if body is Player and not inventory.collectables.is_empty():
		var playerInventory = (body as Player).get_inventory()
		for i in inventory.collectables:
			print("inventorty" + str(i))
			playerInventory.insert(i)
		inventory.remove(0)
