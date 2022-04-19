extends Node

var VP = Vector2.ZERO

var score = 0
var time = 100
var lives = 10
var level = -1
var saveState = [null, null, null, null]
var menu = true
var current_level = 1
var current_position = null
const SAVE_PATH = "user://savegame.sav"
const SECRET = "Venator"
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
		get_node(levels[level]["music"]).play()
	else:
		if level >= levels.size():
			get_node(levels[level - 1]["music"]).stop()
		else:
			get_node(levels[level - 1]["music"]).stop()
			get_node(levels[level]["music"]).play()

var save_data = {
	"saves": {
		"save0": {
			"lives":10
			,"saveState": null
			,"level": get_node_or_null("res://Levels/Level1.tscn")
			,"position": Vector2(200,200)
		},
		"save1": {
			"lives": null
			,"saveState": null
			,"level": get_node_or_null("res://Levels/Level1.tscn")
			,"position": Vector2(200,200)

		},
		"save2": {
			"lives": null
			,"saveState": null
			,"level": get_node_or_null("res://Levels/Level1.tscn")
			,"position": Vector2(200,200)

		},
		"save3": {
			"lives": null
			,"saveState": null
			,"level": get_node_or_null("res://Levels/Level1.tscn")
			,"position": Vector2(200,200)

		}
	}
}

func save_game(save):
	save_data["saves"]["save" + str(save)] = {
		"lives": lives
		,"saveState": saveState[save]
		,"level": current_level
		,"position": var2str(current_position)

	}

	var save_game = File.new()
	save_game.open_encrypted_with_pass(SAVE_PATH, File.WRITE, SECRET)	
	save_game.store_string(to_json(save_data))
	save_game.close()

func load_saves():
	var save_game = File.new()
	if not save_game.file_exists(SAVE_PATH):
		return null
	save_game.open_encrypted_with_pass(SAVE_PATH, File.READ, SECRET)
	var contents = save_game.get_as_text()
	var result_json = JSON.parse(contents)
	if result_json.error == OK:
		save_data = result_json.result
	else:
		print("Error: ", result_json.error)
	save_game.close()
	
	saveState[1] = save_data["saves"]["save" + str(1)]["saveState"]
	saveState[2] = save_data["saves"]["save" + str(2)]["saveState"]
	saveState[3] = save_data["saves"]["save" + str(3)]["saveState"]
	
func load_game(save):
	menu = false
	var save_game = File.new()	
	if not save_game.file_exists(SAVE_PATH):
		return null
	save_game.open_encrypted_with_pass(SAVE_PATH, File.READ, SECRET)
	var contents = save_game.get_as_text()
	var result_json = JSON.parse(contents)
	if result_json.error == OK:
		save_data = result_json.result
	else:
		print("Error: ", result_json.error)
	save_game.close()
	
	lives = save_data["saves"]["save" + str(save)]["lives"]
	saveState[save] = save_data["saves"]["save" + str(save)]["saveState"]
	current_position = str2var(save_data["saves"]["save" + str(save)]["position"])
	var level = save_data["saves"]["save" + str(save)]["level"]
	if save != 0:
		current_level = level
		var _scene = get_tree().change_scene("res://Levels/" + str(level))
		
	#call_deferred("restart_level")
	
func delete_save(save):
	save_data["saves"]["save" + str(save)] = save_data["saves"]["save0"]
	saveState[save] = null

	var save_game = File.new()
	save_game.open_encrypted_with_pass(SAVE_PATH, File.WRITE, SECRET)	
	save_game.store_string(to_json(save_data))
	save_game.close()
