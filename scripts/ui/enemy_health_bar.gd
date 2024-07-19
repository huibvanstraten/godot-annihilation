class_name EnemyHealthBar
extends HealthBar

@export var entity: CharacterBody2D

func _ready():
	EventManager.health_changed.connect(set_health)
	timer.timeout.connect(_on_timer_timeout)
	EventManager.health_depleted.connect(remove_bar)
	init_health()

func set_health(_entity: Node2D, newHealth: int):
	if entity == _entity:
		show()
		super(_entity, newHealth)

func init_health():
	hide()
	health = self.value
	damageBar.max_value = self.value
	damageBar.value = self.value

func remove_bar(_entity: CharacterBody2D):
	if entity == _entity:
		queue_free()

func hide_bar():
	await get_tree().create_timer(5).timeout
	hide()
