extends Node

var VP = Vector2.ZERO

var score = 0
var time = 100
var lives = 10
var level = -1

var levels = [
	{
		"title":"Level 1",
		"subtitle":"Destroy the cargo tanks",
		"asteroids":[Vector2(100,100),Vector2(900,500)],
		"enemies":[],
		"enemies2":[],
		"bosses":[],
		"timer":100,
		"asteroids_spawned":false,
		"enemies_spawned":false,
		"enemies2_spawned":false,
		"bosses_spawned":false,
		"music":"/root/Game/Level1"
	},
	{
		"title":"Level 2",
		"subtitle":"Destroy the cargo tanks and watch out for the armed tank",
		"asteroids":[Vector2(100,100),Vector2(900,500),Vector2(800,200)],
		"enemies":[Vector2(150,500)],
		"enemies2":[],
		"bosses":[],
		"timer":80,
		"asteroids_spawned":false,
		"enemies_spawned":false,
		"enemies2_spawned":false,
		"bosses_spawned":false,
		"music":"/root/Game/Level2"
	},
	{
		"title":"Level 3",
		"subtitle":"Watch out for the new enemies!",
		"asteroids":[Vector2(100,100),Vector2(800,200)],
		"enemies":[],
		"bosses":[],
		"enemies2":[Vector2(50, 100), Vector2(30, 50), Vector2(100, 200)],
		"timer":80,
		"asteroids_spawned":false,
		"enemies_spawned":false,
		"enemies2_spawned":false,
		"bosses_spawned":false,
		"music":"/root/Game/Level3"
	},
	{
		"title":"Level 4",
		"subtitle":"Warning! Boss Battle!",
		"asteroids":[Vector2(100,100)],
		"enemies":[Vector2(150,500)],
		"enemies2":[Vector2(50, 100)],
		"bosses":[Vector2(300, 100)],
		"timer":80,
		"asteroids_spawned":false,
		"enemies_spawned":false,
		"enemies2_spawned":false,
		"bosses_spawned":false,
		"music":"/root/Game/Level4"
	}
]


func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	randomize()
	VP = get_viewport().size
	var _signal = get_tree().get_root().connect("size_changed", self, "_resize")
	reset()

func _physics_process(_delta):
	var A = get_node_or_null("/root/Game/Asteroid_Container")
	var E = get_node_or_null("/root/Game/Enemy_Container")
	var E2 = get_node_or_null("/root/Game/Enemy2_Container")
	var B = get_node_or_null("/root/Game/Boss_Container")
	if A != null and E != null and E2 != null and B != null:
		var L = levels[level]
		if L["asteroids_spawned"] and A.get_child_count() == 0 and L["enemies_spawned"] and E.get_child_count() == 0  and L["enemies2_spawned"] and E2.get_child_count() == 0 and L["bosses_spawned"] and B.get_child_count() == 0:
			next_level()

func reset():
	score = 0
	lives = 10
	time = 100
	level = -1
	for l in levels:
		l["asteroids_spawned"] = false
		l["enemies_spawned"] = false
		l["enemies2_spawned"] = false
		l["bosses_spawned"] = false


func update_score(s):
	score += s
	var hud = get_node_or_null("/root/Game/UI/HUD")
	if hud != null:
		hud.update_score()

func update_lives(l):
	lives += l
	if lives <= 0:
		var _scene = get_tree().change_scene("res://UI/End_Game.tscn")
	var hud = get_node_or_null("/root/Game/UI/HUD")
	if hud != null:
		hud.update_lives()

func update_time(t):
	time += t
	if time <= 0:
		var _scene = get_tree().change_scene("res://UI/End_Game.tscn")
	var hud = get_node_or_null("/root/Game/UI/HUD")
	if hud != null:
		hud.update_time()

func next_level():
	level += 1
	if level >= levels.size():
		var _scene = get_tree().change_scene("res://UI/End_Game.tscn")
	else:
		var Level_Label = get_node_or_null("/root/Game/UI/Level")
		if Level_Label != null:
			Level_Label.show_labels()
	if level == 0:
		get_node(Global.levels[Global.level]["music"]).play()
	else:
		if level >= levels.size():
			get_node(Global.levels[Global.level - 1]["music"]).stop()
		else:
			get_node(Global.levels[Global.level - 1]["music"]).stop()
			get_node(Global.levels[Global.level]["music"]).play()
