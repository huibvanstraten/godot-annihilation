class_name CollectableResource
extends Resource

enum CollectableType { ItemType, BuddyType }

@export var name: String
@export var texture: Texture2D
@export var path: String
@export var active: bool
@export var type: CollectableType
