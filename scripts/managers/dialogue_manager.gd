extends Node2D

var dialogue: Dialogue:
	set(value):
		dialogue = value
		%Icon.texture = value.texture
		%Name.text = value.name
		%Dialogue.text = value.dialogue

func hide_dialogue():
	%UI.hide()
	
func show_dialogue():
	%UI.show()
