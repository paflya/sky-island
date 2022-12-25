extends Area2D



func _on_body_entered(body):
	SceneController.goto_scene("res://maps/level1.tscn")
		
