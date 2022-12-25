extends Node

var totalScore:int

signal coinCollected()

func _collect_coin(score:int):
	totalScore+=score
	emit_signal("coinCollected")

func _connect_hud():
	connect("coinCollected",SceneController.Hud.get_child(0)._update_score)
