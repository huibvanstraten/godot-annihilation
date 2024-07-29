class_name ParalyzeComponent
extends Node

@export var entity: CharacterBody2D

func paralyze():
	EventManager.paralyze.emit(entity)
