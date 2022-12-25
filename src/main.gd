extends Node

@onready var playerContainer=preload("res://src/player/player.tscn")
@onready var hud=preload("res://src/gameplay/hud/hud.tscn")
var currentPlayer:Node2D
var camera:Camera2D
var remTransform:RemoteTransform2D

var is_debugmode:bool

func _process(delta):
	pass
