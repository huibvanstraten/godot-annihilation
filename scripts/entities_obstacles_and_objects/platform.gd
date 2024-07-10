class_name Platform
extends Node2D

enum PlatformType { IDLE, MOVE, LOOP, BREAK }

@export var type: PlatformType = PlatformType.IDLE
@export var speed = 2.0
@export var speedScale = 1.0
@export var breakTime = 1

@export var path: PathFollow2D = null
@export var sprite: AnimatedSprite2D = null
@export var animation: AnimationPlayer = null
@export var breakCollision: Area2D = null

var breaktimer: Timer = null

func _ready():
	match type: 
		PlatformType.IDLE:
			set_process(false)
		PlatformType.MOVE:
			set_process(false)
			animation.play("move")
			animation.speed_scale = speedScale
		PlatformType.LOOP:
			set_process(true)
		PlatformType.BREAK:
			set_process(false)
			animation.connect("animation_finished", _remove_platform)
			breakCollision.connect("body_entered", _start_breaking)
			breaktimer = Timer.new()
			breaktimer.one_shot = true
			add_child(breaktimer)
			breaktimer.connect("timeout", _on_timer_timeout)

func _process(delta):
	match type:
		PlatformType.LOOP:
			path.progress += speed
		PlatformType.BREAK:
			breakTime += 1
			sprite.position += Vector2(0, sin(breakTime) * 2)

func _start_breaking(_body: Node2D):
	set_process(true)
	SfxManager.play("res://assets/audio/sfx/surroundings/heavy-stones-falling.wav")
	breaktimer.start(0.5)

func _on_timer_timeout():
	set_process(false)
	animation.play("break")

func _remove_platform(animName: String):
	if animName == "break":
		queue_free()
