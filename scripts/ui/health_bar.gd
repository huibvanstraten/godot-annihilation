class_name HealthBar
extends ProgressBar

@onready var timer: Timer = $Timer
@onready var damageBar: ProgressBar = $DamageBar

var health: int

func set_health(_entity: Node2D, newHealth: int):
	var previousHealth = health
	health = newHealth
	value = health
	
	if health < previousHealth:
		timer.start()
	else:
		damageBar.value = health

func _on_timer_timeout():
	damageBar.value = health

func _init_health(_entity: CharacterBody2D, startHealth: int):
	health = startHealth
	max_value = health
	value = health
	damageBar.max_value = health
	damageBar.value = health
