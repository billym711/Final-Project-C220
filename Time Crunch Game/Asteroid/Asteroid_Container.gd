extends Node2D

onready var Asteroid = load("res://Asteroid/Asteroid.tscn")

func _physics_process(_delta):
	if get_child_count() == 0 and Global.level < Global.levels.size():
		var level = Global.levels[Global.level]
		if not level["asteroids_spawned"]:
			for pos in level["asteroids"]:
				var asteroid = Asteroid.instance()
				asteroid.position = pos
				add_child(asteroid)
			level["asteroids_spawned"] = true

