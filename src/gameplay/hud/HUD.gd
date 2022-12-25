extends Control

@onready var Score=$Number


func _update_score():
	Score.text=str(Gameplay.totalScore)
