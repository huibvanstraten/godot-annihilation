class_name MoveChoiceComponent
extends Node2D

@onready var stateMachine: BossStateMachine = $"../../StateMachine"

var probabilities: Dictionary

var previousState = null

func choose_next_move() -> BossStateMachine.BossStateType:
	probabilities = stateMachine.STATE_PROBABILITIES
	return get_next_state() 

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
		if enumKeys[i] == previousState:
			continue  # Skip the previous value
		if randomValue <= cumulativeWeights[i]:
			previousState = enumKeys[i]
			return enumKeys[i]
	
	# Fallback in case of floating-point precision issues
	previousState = enumKeys[6]
	return enumKeys[6]
	
