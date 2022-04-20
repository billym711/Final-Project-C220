extends Node2D

onready var Player = load("res://Player/Player.tscn")
var player

func _physics_process(_delta):
	if get_child_count() == 0:
		player = Player.instance()
		player.position = Global.current_position
		add_child(player)
	Global.current_position = player.position

