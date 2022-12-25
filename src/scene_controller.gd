extends Node

var loader
var wait_frames
var time_max = 100 # msec
var current_scene:Node2D
var point:Marker2D
var Hud:CanvasLayer

enum scenetype{
	platformer,
	menu
}

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() -1)

###Not used
func _process(time):
	if loader == null:
		# no need to process anymore
		set_process(false)
		return

	# Wait for frames to let the "loading" animation show up.
	if wait_frames > 0:
		wait_frames -= 1
		return

	var t = Time.get_ticks_msec()
	# Use "time_max" to control for how long we block this thread.
	while Time.get_ticks_msec() < t + time_max:
		# Poll your loader.
		var err = loader.poll()

		if err == ERR_FILE_EOF: # Finished loading.
			var resource = loader.get_resource()
			loader = null
			set_new_scene(resource)
			break
		elif err == OK:
			update_progress()
		else: # Error during loading.
			loader.show_error()
			loader = null
			break

func update_progress():
	var progress = float(loader.get_stage()) / loader.get_stage_count()
	# Update your progress bar?
	get_node("progress").set_progress(progress)
	# ...or update a progress animation?
	var length = get_node("animation").get_current_animation_length()
	# Call this on a paused animation. Use "true" as the second argument to
	# force the animation to update.
	get_node("animation").seek(progress * length, true)
 
###used
func goto_scene(path): # Game requests to switch to this scene.
	loader = load(path)
	current_scene.queue_free()
	set_new_scene(loader)
	
	return
	###NOT USED
	if loader == null: # Check for errors.
		loader.show_error()
		return
	set_process(true)
	current_scene.queue_free() # Get rid of the old scene.
	# Start your "loading..." animation.
	wait_frames = 1
	

func set_new_scene(scene_resource):
	current_scene = scene_resource.instantiate()
	get_node("/root").add_child(current_scene)
	init_scene(current_scene.get_meta("is_platformer",false))

func init_scene(type:bool):
	if !type:
		Inputhandler.is_input_allowed=false
		return
	point= current_scene.find_child("Player_Spawn")
	
	Main.currentPlayer=Main.playerContainer.instantiate()
	Main.currentPlayer.transform=point.global_transform
	Main.remTransform=RemoteTransform2D.new()
	Main.currentPlayer.add_child(Main.remTransform)
	
	
	
	current_scene.add_child(Main.currentPlayer)
	Main.camera=Camera2D.new()
	current_scene.add_child(Main.camera)
	Main.remTransform.remote_path=Main.camera.get_path()
	Main.camera.current=true
	Main.camera.zoom=Vector2(2,2)
	Hud=Main.hud.instantiate()
	current_scene.add_child(Hud)
	Gameplay._connect_hud()
	Gameplay.totalScore=0
	
	Inputhandler.is_input_allowed=true
	
