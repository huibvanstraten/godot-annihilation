class_name Transition
extends Area2D

@onready var marker: Marker2D = $Marker2D

func _on_body_entered(body):
	body.global_position = marker.global_position


func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

