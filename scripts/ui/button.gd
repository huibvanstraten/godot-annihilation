extends Button

func _ready():
	grab_focus()
	
func _input(_event):
	if Input.is_action_just_pressed("move_down") or Input.is_action_just_pressed("move_up"):
		SfxManager.play("res://assets/audio/sfx/ui/button_press.wav")
