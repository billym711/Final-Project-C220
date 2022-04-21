extends Node

var VP = Vector2.ZERO

var score = 0
var time = 100
var lives = 10
var health = 20
var damage = 1
var armor = 0
var damage_upgrades = 0
var level = 1
var saveState = [null, null, null, null]
var menu = true
var current_level = 1
var starting_position = Vector2(500, 500)
var current_position = starting_position
const SAVE_PATH = "user://savegame.sav"
const SECRET = "Venator"

var canSave = true
var zombieTarget = null


func _ready():
	load_saves()
	pause_mode = Node.PAUSE_MODE_PROCESS
	randomize()
	VP = get_viewport().size
	var _signal = get_tree().get_root().connect("size_changed", self, "_resize")
	score = 0
	time = 100
	lives = 10
	health = 20
	damage = 1
	armor = 0
	damage_upgrades = 0
	current_level = 1
	current_position = starting_position

func update_score(s):
	score += s
	var nextLevel = str(Global.current_level)
	var hud = get_node_or_null("/root/Level" + nextLevel + "/Camera/UI/HUD")
	if hud != null:
		hud.update_score()
		
func update_health(h):
	health += h
	var nextLevel = str(Global.current_level)
	var hud = get_node_or_null("/root/Level" + nextLevel + "/Camera/UI/HUD")
	if hud != null:
		hud.update_health()

func update_lives(l):
	lives += l
	if lives <= 0:
		var _scene = get_tree().change_scene("res://UI/End_Game.tscn")
	var nextLevel = str(Global.current_level)
	var hud = get_node_or_null("/root/Level" + nextLevel + "/Camera/UI/HUD")
	if hud != null:
		hud.update_lives()

func update_time(t):
	time += t
	if time <= 0:
		var _scene = get_tree().change_scene("res://UI/End_Game.tscn")
	var nextLevel = str(Global.current_level)
	var hud = get_node_or_null("/root/Level" + nextLevel + "/Camera/UI/HUD")
	if hud != null:
		hud.update_time()

var save_data = {
	"saves": {
		"save0": {
			"health":20
			,"lives":10
			,"score":0
			,"time":100
			,"saveState": null
			,"level": get_node_or_null("res://Levels/Level1.tscn")
			,"position": Vector2(500, 500)
			,"damage": 1
			,"damage_upgrades": 0
			,"armor": 0
		},
		"save1": {
			"health":20
			,"lives": null
			,"score":0
			,"time":100
			,"saveState": null
			,"level": get_node_or_null("res://Levels/Level1.tscn")
			,"position": Vector2(500, 500)
			,"damage": 1
			,"damage_upgrades": 0
			,"armor": 0

		},
		"save2": {
			"health":20
			,"lives": null
			,"score":0
			,"time":100
			,"saveState": null
			,"level": get_node_or_null("res://Levels/Level1.tscn")
			,"position": Vector2(500, 500)
			,"damage": 1
			,"damage_upgrades": 0
			,"armor": 0

		},
		"save3": {
			"health":20
			,"lives": null
			,"score":0
			,"time":100
			,"saveState": null
			,"level": get_node_or_null("res://Levels/Level1.tscn")
			,"position": Vector2(500, 500)
			,"damage": 1
			,"damage_upgrades": 0
			,"armor": 0

		}
	}
}

func save_game(save):
	save_data["saves"]["save" + str(save)] = {
		"health": health
		,"lives": lives
		,"score": score
		,"time": time
		,"saveState": saveState[save]
		,"level": current_level
		,"position": var2str(current_position)
		,"damage": damage
		,"damage_upgrades": damage_upgrades
		,"armor": armor

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
	
	health = save_data["saves"]["save" + str(save)]["health"]
	lives = save_data["saves"]["save" + str(save)]["lives"]
	score = save_data["saves"]["save" + str(save)]["score"]
	time = save_data["saves"]["save" + str(save)]["time"]
	damage = save_data["saves"]["save" + str(save)]["damage"]
	damage_upgrades = save_data["saves"]["save" + str(save)]["damage_upgrades"]
	armor = save_data["saves"]["save" + str(save)]["armor"]
	saveState[save] = save_data["saves"]["save" + str(save)]["saveState"]
	current_position = str2var(save_data["saves"]["save" + str(save)]["position"])
	var level = save_data["saves"]["save" + str(save)]["level"]
	if save != 0:
		current_level = level
		var _scene = get_tree().change_scene("res://Levels/Level" + str(level) + ".tscn")
		
	#call_deferred("restart_level")
	
func delete_save(save):
	save_data["saves"]["save" + str(save)] = save_data["saves"]["save0"]
	saveState[save] = null

	var save_game = File.new()
	save_game.open_encrypted_with_pass(SAVE_PATH, File.WRITE, SECRET)	
	save_game.store_string(to_json(save_data))
	save_game.close()
