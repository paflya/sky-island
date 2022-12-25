extends Node

var is_input_allowed:bool
const MAX_ZOOM_IN=4
const MAX_ZOOM_OUT=2

func _ready():
	is_input_allowed=false
	

func _input(event):
	if !is_input_allowed:
		return
	if event.is_action_pressed("jump"):
		Main.currentPlayer.character_jump()
	Main.currentPlayer.character_move(Input.get_axis("left","right"))
	if event.is_action_pressed("zoom_in"):
		if (Main.camera.zoom.x<MAX_ZOOM_IN):
			Main.camera.zoom+=Vector2(1,1)
	if event.is_action_pressed("zoom_out"):
		if (Main.camera.zoom.x>MAX_ZOOM_OUT):
			Main.camera.zoom-=Vector2(1,1)
