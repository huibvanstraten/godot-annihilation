class_name Collectable
extends Area2D

@export var collectable: CollectableResource

func _ready():
	self.connect("body_entered", _on_body_entered)
	self.connect("area_entered", _on_area_entered)

func collect(inventory: Inventory):
	SfxManager.play("res://assets/audio/sfx/ui/button_press.wav")
	inventory.insert(collectable)
	queue_free()

func _on_body_entered(body):
	if body is Player:
		var inventory = (body as Player).get_inventory(collectable.type)
		collect(inventory)

func _on_area_entered(area):
	if area is Buddy:
		print("detecting buddy")
		var inventory = (area as Buddy).get_inventory()
		collect(inventory)
