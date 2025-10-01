extends Node

@onready var hud = $"../GameUI/HUD/Label"

var score = 1

func add_point():
	score += 1
	hud.text = "Score: " + str(score)
