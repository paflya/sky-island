extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

enum state_machine{
	idle,
	run,
	hanging,
	mid_air,
	jumped,
	landed
}
var current_direction
@export var current_state:state_machine
@onready var animation=$AnimatedSprite2D
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var jumpsound=$jump
@onready var runsound=$run

func _physics_process(delta):
	# Add the gravity.
	current_state=state_machine.idle
	if not is_on_floor():
		velocity.y += gravity * delta
	if(current_direction==-1):
		animation.flip_h=true
	if (current_direction==1): 
		animation.flip_h=false
	if (velocity.x<0 or velocity.x>0):
		current_state=state_machine.run
	if (velocity.y<0):
		current_state=state_machine.jumped
	if (velocity.y>0):
		current_state=state_machine.mid_air
	animation.play(match_animations())
	move_and_slide()

func character_jump():
	if is_on_floor():
		velocity.y = JUMP_VELOCITY
		jumpsound.play()

func character_move(direction):
	current_direction=direction
	if direction:
		velocity.x = direction * SPEED
		if is_on_floor() and runsound.playing==false:
			runsound.play()
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

func match_animations()->String:
	match current_state:
		0:return "idle"
		1:return "run"
		2:return "hanging"
		3:return "mid-air"
		4:return "jump"
		5:return "landed"
	return "animation"
