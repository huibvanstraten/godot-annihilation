extends Panel

@onready var backgroundSprite: Sprite2D = $background
@onready var collectableSprite: Sprite2D = $CenterContainer/Panel/item

func update(collectable: CollectableResource) -> int:
	var count = 0
	
	if !collectable:
		backgroundSprite.frame = 0
		collectableSprite.visible = false
	else:
		count += 1
		backgroundSprite.frame = 1
		collectableSprite.visible = true
		collectableSprite.texture = collectable.texture
	
	return count

func set_sprite_frame(isSelected: bool):
	if isSelected:
		backgroundSprite.frame = 2
	else:
		backgroundSprite.frame = 1
