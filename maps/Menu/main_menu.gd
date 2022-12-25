extends Control



func _on_texture_button_2_pressed():
	get_tree().quit()


func _on_texture_button_pressed():
	SceneController.goto_scene("res://maps/level1.tscn")


func _on_texture_button_mouse_entered():
	$AudioStreamPlayer2D.play()
