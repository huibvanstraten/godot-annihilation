class_name InteractionTriggerArea
extends Area2D

func _on_body_entered(_body):
	EventManager.emit_signal("interact", true)

func _on_body_exited(_body):
	EventManager.emit_signal("interact", false)
