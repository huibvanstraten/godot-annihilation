class_name BuddyComponent
extends Node

@export var buddySpawnMarker: Marker2D = null

@onready var physicsComponent: PhysicsComponent =  $"../Physics"

var buddy: Buddy

func _ready():
	set_physics_process(false)

func _physics_process(_delta):
	if not buddy.isFlying:
		buddy.global_position = buddySpawnMarker.global_position
		if physicsComponent.direction.x != 0:
			buddy.scale.x = physicsComponent.direction.x

func activate(path: String):
	buddy = load(path).instantiate()
	buddy.global_position = buddySpawnMarker.global_position
	buddy.scale.x = 1
	get_tree().root.add_child(buddy)
	
	set_physics_process(true)
	
func deactivate():
	set_physics_process(false)
	buddy.queue_free()
