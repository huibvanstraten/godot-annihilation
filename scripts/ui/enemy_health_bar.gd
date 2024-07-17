class_name EnemyHealthBar
extends HealthBar

@export var entity: CharacterBody2D

func _ready():
	#EventManager.init_health_bar.connect(_init_health)
	EventManager.health_changed.connect(set_health)
	timer.timeout.connect(_on_timer_timeout)
	EventManager.health_depleted.connect(remove_bar)
	hide()

func set_health(_entity: Node2D, newHealth: int):
	if entity == _entity:
		show()
		super(_entity, newHealth)

#func _init_health(_entity: Node2D, newHealth: int):
	#print("init")
	#print(entity)
	#print(_entity)
	#if entity == _entity:
		#print("succes")
		#super(_entity, newHealth)

func remove_bar(_entity: CharacterBody2D):
	if entity == _entity:
		queue_free()

func hide_bar():
	await get_tree().create_timer(5).timeout
	hide()
