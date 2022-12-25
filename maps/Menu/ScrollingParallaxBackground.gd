extends ParallaxBackground

@export var SCROLL_SPEED:int
@export var Backgrounds:Array[ParallaxLayer]
@export var BackgroundImages:Array[Texture]

func _ready():
	Backgrounds.append(get_child(1))
	Backgrounds.append(get_child(2))
	Backgrounds.append(get_child(3))
	Backgrounds.append(get_child(4))
	var i=0
	for Background in Backgrounds:
		Background.get_child(0).texture=BackgroundImages[i]
		i+=1
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for Background in Backgrounds:
		Background.motion_offset.x-=delta*SCROLL_SPEED*Background.motion_scale.x

