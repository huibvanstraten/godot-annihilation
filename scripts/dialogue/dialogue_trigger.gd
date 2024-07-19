class_name DialogueTrigger
extends Node2D

@export var triggerId: int
@export var dialogue: Dialogue
@export var automatedTrigger: bool
@export var oneTime: bool

@onready var triggerArea: InteractionTriggerArea = $InteractionTriggerArea

var dialogueOpened: bool = false
var canTalk: bool = false

func _ready():
	EventManager.connect("interact", _on_interact)
	triggerArea.triggerAreaId = triggerId

func _input(event):
	if canTalk:
		if event.is_action_pressed("interact") or automatedTrigger:
			if not dialogueOpened:
				automatedTrigger = false
				dialogueOpened = true
				EventManager.emit_signal("freeze_player", true)
				DialogueManager.dialogue = dialogue
				DialogueManager.show_dialogue()
			elif dialogue.hasNext:
				DialogueManager.dialogue = dialogue.next
				dialogue = dialogue.next
			else:
				DialogueManager.hide_dialogue()
				canTalk = false
				dialogueOpened = false
				EventManager.emit_signal("interact", false, triggerArea.triggerAreaId)
				EventManager.emit_signal("freeze_player", false)
				if oneTime:
					queue_free()
	
func _on_interact(canInteract: bool, triggerAreaId: int):
	if triggerId == triggerAreaId:
		canTalk = canInteract
		if canInteract:
			EventManager.emit_signal("freeze_player", true)
		else:
			EventManager.emit_signal("freeze_player", false)
