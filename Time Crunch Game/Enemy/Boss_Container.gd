extends Node2D

onready var Boss = load("res://Enemy/Boss.tscn")

func _physics_process(_delta):
	if get_child_count() == 0 and Global.level < Global.levels.size():
		var level = Global.levels[Global.level]
		if not level["bosses_spawned"]:
			for pos in level["bosses"]:
				var boss = Boss.instance()
				boss.position = pos
				add_child(boss)
			level["bosses_spawned"] = true
		
