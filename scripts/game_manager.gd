extends Node

@onready var hud = $"../GameUI/Panel/PointsLabel"

var score = 0

func add_point():
	score += 1
	hud.text = "Score: " + str(score)
