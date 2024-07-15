class_name TransitionCamera
extends Camera2D

func _ready():
	EventManager.transition_to_area.connect(_on_transition_to_area)
	
func _on_transition_to_area(body: Node2D):
	global_position = body.global_position
