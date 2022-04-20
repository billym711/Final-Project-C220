extends Node2D

func _ready():
	Global.update_lives(0)
	Global.update_score(0)
	Global.update_health(0)
	Global.ready()
