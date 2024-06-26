class_name HealthComponent
extends Node

signal health_depleted
signal entity_hit

@export var defaultHealth: float = 20

var healthLeft: float = 0

func _ready():
	reset_health()

func hit(damage: float):
	healthLeft -= damage
	var entity = get_parent().get_parent()
	if entity is CharacterBody2D:
		if (healthLeft <= 0.0):
			EventManager.emit_signal("health_depleted", entity)
		elif (healthLeft > 0.0):
			EventManager.emit_signal("entity_hit", entity)
	else:
		push_error("entity not found")	

func reset_health(amount: float = defaultHealth):
	healthLeft = amount
