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
	



func fun_bogey_calculator(number):
	var bogeystring = ""
	print("div 100: " + str(number / 100))
	match number / 100:
		1:
			bogeystring += "Centuple "
		2:
			bogeystring += "Duocentuple "
		3:
			bogeystring += "Tricentuple "
		4:
			bogeystring += "Quadrocentuple "
		5:
			bogeystring += "Pentacentuple "
		6:
			bogeystring += "Sextacentuple "
		7:
			bogeystring += "Septacentuple "
		8:
			bogeystring += "Octocentuple "
		9:
			bogeystring += "Novacentuple "
	print("mod 100 div 10: " + str((number % 100) / 10))
	match (number % 100) / 10:
		1:
			bogeystring += "Decuple "
		2:
			bogeystring += "Duodecuple "
		3:
			bogeystring += "Tridecuple "
		4:
			bogeystring += "Quadecuple "
		5:
			bogeystring += "Pentadecuple "
		6:
			bogeystring += "Sexdecuple "
		7:
			bogeystring += "Septdecuple "
		8:
			bogeystring += "Octodecuple "
		9:
			bogeystring += "Novadecuple "
	print("mod 10: " + str(number % 10))
	match number % 10:
		1:
			bogeystring += "Single "
		2:
			bogeystring += "Double "
		3:
			bogeystring += "Triple "
		4:
			bogeystring += "Quadruple "
		5:
			bogeystring += "Pentuple "
		6:
			bogeystring += "Sextuple "
		7:
			bogeystring += "Septuple "
		8:
			bogeystring += "Octuple "
		9:
			bogeystring += "Novuple "
	bogeystring += "Bogey!"
	if number == 1:
		bogeystring = "Hole in One!"
	return bogeystring

func boring_bogey_calculator(number):
	var bogeystring = ""
	match number:
		1:
			bogeystring = "Condor!"
		2:
			bogeystring = "Albatross!"
		3:
			bogeystring = "Eagle!"
		4:
			bogeystring = "Birdey!"
		5:
			bogeystring = "Par!"
		6:
			bogeystring = "Bogey!"
		7:
			bogeystring = "Double Bogey!"
		8:
			bogeystring = "Triple Bogey!"
		9:
			bogeystring = "Quadruple Bogey!"
		10:
			bogeystring = "Pentuple Bogey!"
		11:
			bogeystring = "Sextuple Bogey!"
		12:
			bogeystring = "Septuple Bogey!"
		13:
			bogeystring = "Octuple Bogey!"
	if number >= 14:
		bogeystring = str(number-5) + "x Bogey!"
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
