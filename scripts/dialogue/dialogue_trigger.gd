class_name DialogueTrigger
extends Node2D

@export var dialogue: Dialogue
@export var automatedTrigger: bool
@export var oneTime: bool

var dialogueOpened: bool = false
var canTalk: bool = false

func _ready():
	EventManager.connect("interact", _on_interact)

func _input(event):
	if canTalk:
		if event.is_action_pressed("interact") or automatedTrigger:
			if not dialogueOpened:
				DialogueManager.dialogue = dialogue
				DialogueManager.show_dialogue()
				dialogueOpened = true
				automatedTrigger = false
				EventManager.emit_signal("freeze_player", true)
			elif dialogue.next:
				DialogueManager.dialogue = dialogue.next
				dialogue = dialogue.next
			else:
				DialogueManager.hide_dialogue()
				canTalk = false
				dialogueOpened = false
				EventManager.emit_signal("interact", false)
				EventManager.emit_signal("freeze_player", false)
				if oneTime:
					queue_free()
	
func _on_interact(canInteract: bool):
	canTalk = canInteract
	if automatedTrigger:
		EventManager.emit_signal("freeze_player", true)
	if not canInteract:
		EventManager.emit_signal("freeze_player", false)
