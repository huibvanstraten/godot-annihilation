extends Panel

@onready var backgroundSprite: Sprite2D = $background
@onready var itemSprite: Sprite2D = $CenterContainer/Panel/item

func update(item: InventoryItem) -> int:
	var count = 0
	
	if !item:
		backgroundSprite.frame = 0
		itemSprite.visible = false
	else:
		count += 1
		backgroundSprite.frame = 1
		itemSprite.visible = true
		itemSprite.texture = item.texture
	
	return count

func set_sprite_frame(isSelected: bool):
	if isSelected:
		backgroundSprite.frame = 2
	else:
		backgroundSprite.frame = 1
