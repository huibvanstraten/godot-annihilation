class_name Transition
extends Area2D

enum TransitionDirection { Left, Right, Up, Down }

@export var transitionsToAreaPath: String
@export var transitionAreaId: String
@export var transitionDirection: TransitionDirection

@onready var marker: Marker2D = $Marker2D

func _on_body_entered(body):
	if body is Player:
		body.global_position = marker.global_position
		EventManager.transition_to_area.emit(transitionsToAreaPath)
