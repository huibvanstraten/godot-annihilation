class_name StateComponent
extends Node2D

@onready var stateMachine: BossStateMachine = $"../../StateMachine"
@onready var timer: Timer = $Timer

var toWalkState: bool = false

var probabilities: Dictionary

var previousState = null

func choose_next_move() -> BossStateMachine.BossStateType:
	probabilities = stateMachine.STATE_PROBABILITIES
	return get_next_state() 

func start_walk_state_timer():
	if timer.is_stopped() and !toWalkState:
		print("starting timer")
		toWalkState = false
		timer.start()
	
func stop_walk_state_timer():
	toWalkState = false
	timer.stop()

func _on_timer_timeout():
	print("time out")
	toWalkState = true

func get_next_state() -> BossStateMachine.BossStateType:
	var totalWeight = 0.0
	var cumulativeWeights = []
	var enumKeys = probabilities.keys()
	
	# Calculate total weight and cumulative weights
	for key in probabilities.keys():
		if key != previousState:
			totalWeight += probabilities[key]
		cumulativeWeights.append(totalWeight)
	
	var randomValue = randf() * totalWeight
	
	for i in range(cumulativeWeights.size()):
		if randomValue <= cumulativeWeights[i]:
			previousState = enumKeys[i]
			return enumKeys[i]
	
	# Fallback in case of floating-point precision issues
	previousState = enumKeys[6]
	return enumKeys[6]
