extends Area2D

enum ChestStates {
	CLOSED,
	UNLOCK,
	OPEN
}

var state = ChestStates.CLOSED
var interact_disabled: bool = true
var player_near: bool = false

@onready var chest_animation = $AnimatedSprite2D/AnimationPlayer
@onready var chest_collision = $CollisionShape2D

var chest_text_box = preload("res://scenes/text_box.tscn")
var text_box

func _ready():
	text_box = chest_text_box.instantiate()
	add_child(text_box)
	
	chest_animation.connect("animation_finished", _on_AnimationPlayer_animation_finished)
	text_box.connect("text_finished", change_interaction_state)

func _on_body_entered(body):
	print(body.name)
	if body.name == "Player":
		player_near = true

func _on_body_exited(body):
	if body.name == "Player":
		player_near = false

func _input(_event):
	if Input.is_action_just_pressed("interact") and player_near and !interact_disabled:
		interact()
		#text_box.show_textbox()

func interact():
	match state:
		ChestStates.CLOSED:
			unlock_chest()
		ChestStates.OPEN:
			close_chest()
		ChestStates.UNLOCK:
			pass

func close_chest():
	state = ChestStates.CLOSED
	chest_animation.play("closed")
	change_interaction_state()

func open_chest():
	state = ChestStates.OPEN
	chest_animation.play("open")
	change_interaction_state()
	
func unlock_chest():
	state = ChestStates.UNLOCK
	chest_animation.play("unlock")
	change_interaction_state(true)
	text_box.queue_text("You have found a sword. Hells fucking Yeah!")

func _on_AnimationPlayer_animation_finished(anim_name):
	match anim_name:
		"unlock":
			open_chest()
		"open":
			pass
		"close":
			pass

func change_interaction_state(is_disabled: bool = false):
	interact_disabled = is_disabled
