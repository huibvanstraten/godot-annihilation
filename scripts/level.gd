extends Node2D

@onready var start_position = $StartPosition

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene() 


func _on_deathzone_body_entered(body):
	body.velocity = Vector2.ZERO
	body.global_position = start_position.global_position
