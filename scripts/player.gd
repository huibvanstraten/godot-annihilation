extends CharacterBody2D

@export var gravity = 600

const SPEED = 500.0
const JUMP_VELOCITY = -350.0
const MAX_VELOCITY = 500

@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	var direction = Input.get_axis("move_left", "move_right")
	
	_move(direction)
	_jump(delta)
	_update_animations(direction)

func _move(direction):
	if direction != 0:
		animated_sprite.flip_h = (direction == -1)
		#velocity.x = move_toward(velocity.x, 10, SPEED)
	
	velocity.x = direction * SPEED
	
	move_and_slide()
	

func _jump(delta): 
	if not is_on_floor(): 
		velocity.y += gravity * delta
		if velocity.y > MAX_VELOCITY: velocity.y = MAX_VELOCITY
	
	if Input.is_action_just_pressed("jump") and is_on_floor(): 
		velocity.y = JUMP_VELOCITY
		
func _update_animations(direction):
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")	
	else:
		if velocity.y < 0:
			animated_sprite.play("jump")
		else: 
			animated_sprite.play("fall")
