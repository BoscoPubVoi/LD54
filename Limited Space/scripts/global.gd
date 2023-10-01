extends Node

#any persistant variables and stuff
var PLAYER_SCORE : Array[int]
var CURRENT_LEVEL : int = 0

#level count should probably be handled differently but maybe it's fine for gamejam 
var LEVEL_COUNT : int = 1

var MAX_GOLFERS : int = 50

func _ready():
	PrepScore()

func PrepScore():
	PLAYER_SCORE = []
	PLAYER_SCORE.resize(LEVEL_COUNT)

func IncrementScore():
	PLAYER_SCORE[CURRENT_LEVEL - 1] += 1
	get_tree().get_first_node_in_group("UI").updateScore(PLAYER_SCORE[CURRENT_LEVEL - 1])

func GetTotalScore():
	var score = 0
	for i in CURRENT_LEVEL:
		score += PLAYER_SCORE[i]
	
	return score
	



func bogey_calculator(number):
	var bogeystring = ""
	match number / 100:
		1:
			bogeystring += "Centuple "
		2:
			bogeystring += "Double Centuple "
		3:
			bogeystring += "Triple Centuple "
		4:
			bogeystring += "Quadruple Centuple "
		5:
			bogeystring += "Pentuple Centuple "
		6:
			bogeystring += "Sextuple Centuple "
		7:
			bogeystring += "Septuple Centuple "
		8:
			bogeystring += "Octuple Centuple "
		9:
			bogeystring += "Novuple Centuple "
	match number / 10:
		1:
			bogeystring += "Decuple "
		2:
			bogeystring += "Double Decuple "
		3:
			bogeystring += "Triple Decuple "
		4:
			bogeystring += "Quadruple Decuple "
		5:
			bogeystring += "Pentuple Decuple "
		6:
			bogeystring += "Sextuple Decuple "
		7:
			bogeystring += "Septuple Decuple "
		8:
			bogeystring += "Octuple Decuple "
		9:
			bogeystring += "Novuple Decuple "
	match number % 10:
		1:
			bogeystring = "Single "
		2:
			bogeystring += "Double  "
		3:
			bogeystring += "Triple "
		4:
			bogeystring += "Quadruple  "
		5:
			bogeystring += "Pentuple  "
		6:
			bogeystring += "Sextuple  "
		7:
			bogeystring += "Septuple  "
		8:
			bogeystring += "Octuple  "
		9:
			bogeystring += "Novuple  "
	bogeystring += "Bogey!"
	return bogeystring


func SpringStep(currentValue : float, velocity : float, targetValue : float, time_step : float, damping : float = 0.2, oscillation : float = 30):
	var squareOsci : float = oscillation * oscillation
	var squareTime : float = time_step * time_step
	var newPos : float = 1.0 + (2.0 * time_step * damping * oscillation) ##FirstPart of equation
	var deltaInverse : float = 1.0 / (newPos + (squareOsci * squareTime))
	var deltaPos : float = (newPos * currentValue) + (time_step * velocity) + (squareOsci * squareTime * targetValue)
	var deltaVelocity : float = velocity + (time_step * squareOsci * (targetValue - currentValue))

	# Normally we would pass velocity as ref and update it here and return new value between current one and target
	# but this is not possible in script so we return array, new position/value and new velocity
	var newValues = []
	newValues.resize(2)
	newValues[0] = deltaPos * deltaInverse #new value
	newValues[1] = deltaVelocity * deltaInverse #new velocity

	return newValues;