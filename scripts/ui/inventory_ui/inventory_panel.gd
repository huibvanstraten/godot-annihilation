class_name InventoryPanel
extends Panel

@onready var backgroundSprite: Sprite2D = $background
@onready var collectableSprite: Sprite2D = $CenterContainer/Panel/item

var hasItem: bool = false

func update(collectable: CollectableResource):
	
	if !collectable:
		backgroundSprite.frame = 0
		collectableSprite.visible = false
		hasItem = false
	else:
		backgroundSprite.frame = 1
		collectableSprite.visible = true
		collectableSprite.texture = collectable.texture
		hasItem = true

func set_sprite_frame(isSelected: bool):
	if isSelected:
		backgroundSprite.frame = 2
	else:
		backgroundSprite.frame = 1
