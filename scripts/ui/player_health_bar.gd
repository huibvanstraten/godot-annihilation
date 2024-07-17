class_name PlayerHealthBar
extends HealthBar

var entity: CharacterBody2D

func _ready():
	EventManager.init_health_bar.connect(_init_health)
	EventManager.health_changed.connect(set_health)
	EventManager.spawn_player.connect(set_entity)
	timer.timeout.connect(_on_timer_timeout)

func _init_health(_entity: Node2D, newHealth: int):
	if entity == _entity:
		super(_entity, newHealth)

func set_health(_entity: Node2D, newHealth: int):
	if entity == _entity:
		super(_entity, newHealth)

func set_entity(player: Player):
	entity = player
