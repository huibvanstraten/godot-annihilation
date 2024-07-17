class_name InteractionTriggerArea
extends Area2D

var triggerAreaId: int

func _on_body_entered(_body):
	EventManager.emit_signal("interact", true, triggerAreaId)

func _on_body_exited(_body):
	EventManager.emit_signal("interact", false, triggerAreaId)
