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
