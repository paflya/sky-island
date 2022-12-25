extends Node2D

@onready var sprite=$Sprite2D
@export var stats:food_collectible
@onready var sound=$AudioStreamPlayer2D
@onready var trigger=$Area2D
func _ready():
	sprite.texture=stats.img


func _on_area_2d_body_entered(body):
	Gameplay._collect_coin(stats.points)
	sound.play()
	await sound.finished
	self.queue_free()
