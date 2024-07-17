class_name MovingCamera
extends Camera2D

@export var scroll_speed: float = 100.0  # Speed at which the camera moves

var startPoint: float

func _ready():
	startPoint = global_position.x

func _process(delta: float) -> void:
	global_position.x += scroll_speed * delta

func set_restart_position():
	global_position.x = startPoint
