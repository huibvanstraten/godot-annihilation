class_name HealthComponent
extends Node

@export var entity: CharacterBody2D
@export var maxHealth: float = 100
var currentHealth: float = 0

func _ready():
	currentHealth = maxHealth
	EventManager.init_health_bar.emit(entity, currentHealth)
	
func hit(damage: float):
	currentHealth -= damage
	EventManager.emit_signal("health_changed", entity, currentHealth)
	if (currentHealth <= 0.0):
		EventManager.emit_signal("health_depleted", entity)
	elif (currentHealth > 0.0):
		EventManager.emit_signal("entity_hit", entity)

func set_health(newHealth: float = maxHealth):
	currentHealth = min(newHealth, maxHealth)
	EventManager.emit_signal("health_changed", entity, currentHealth)
