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
	if body is Player and inventory.get_filled_collectables_amount() != 0 :
		for collectable in inventory.collectables:
			var playerInventory = (body as Player).get_inventory(collectable.type)
			playerInventory.insert(collectable)
		inventory.remove(0)
		EventManager.remove_buddy.emit(self)
