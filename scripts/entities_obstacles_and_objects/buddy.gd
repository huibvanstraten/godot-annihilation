class_name Buddy
extends Node2D

@export var animationPlayer: AnimationPlayer = null
@export var flyComponent: FlyComponent = null

@export var inventory: Inventory

var isFlying: bool = false

var startPosition: Vector2
var targetPosition: Vector2
