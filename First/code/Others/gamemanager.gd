extends Node

var score = 0

func add_point():
	score += 1
	scoreLabel.text = str(score)
