extends Node

#any persistant variables and stuff
var PLAYER_SCORE : Array[int]
var CURRENT_LEVEL : int

#level count should probably be handled differently but maybe it's fine for gamejam 
var LEVEL_COUNT : int = 1

func PrepScore():
	PLAYER_SCORE = [LEVEL_COUNT]

func IncrementScore():
	PLAYER_SCORE[CURRENT_LEVEL - 1] += 1

func GetTotalScore():
	var score = 0
	for i in CURRENT_LEVEL:
		score += PLAYER_SCORE[i]
	
	return score
	
