extends Node2D

onready var Enemy2 = load("res://Enemy/Enemy2.tscn")

func _physics_process(_delta):
	if get_child_count() == 0 and Global.level < Global.levels.size():
		var level = Global.levels[Global.level]
		if not level["enemies2_spawned"]:
			for pos in level["enemies2"]:
				var enemy2 = Enemy2.instance()
				enemy2.position = pos
				add_child(enemy2)
			level["enemies2_spawned"] = true
		
