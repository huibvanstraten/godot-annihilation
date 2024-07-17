class_name PlayerHealthBar
extends HealthBar

var entity: CharacterBody2D

func _ready():
	EventManager.spawn_player.connect(set_entity)
	EventManager.init_health_bar.connect(_init_health)
	EventManager.health_changed.connect(set_health)
	timer.timeout.connect(_on_timer_timeout)

func _init_health(_entity: Node2D, newHealth: int):
	print("init health")
	print(entity)
	if entity == _entity:
		super(_entity, newHealth)

func set_health(_entity: Node2D, newHealth: int):
	if entity == _entity:
		super(_entity, newHealth)

func set_entity(player: Player):
	print("init player")
	print(player)
	entity = player
