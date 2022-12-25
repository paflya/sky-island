extends Area2D
@onready var failsound=preload("res://assets/sounds/fail.mp3")
@onready var winsound=preload("res://assets/sounds/win.mp3")

func _on_body_entered(body):
	Inputhandler.is_input_allowed=false
	if (Gameplay.totalScore>7000):	
		$AudioStreamPlayer2D3.stream=winsound
	else:
		$AudioStreamPlayer2D3.stream=failsound
	$AudioStreamPlayer2D3.play()
	await $AudioStreamPlayer2D3.finished
	SceneController.goto_scene("res://maps/Menu/menu_screen.tscn")
