extends Node

var death_zone = 1000

var jewels = 0
var lives = 10
var current_position = Vector2(200,200)

var GameOver = false
var GameOverText
var playText = "Play"
var saveState = [null, null, null, null]
var menu = true

const SAVE_PATH = "user://jonabarg_savegame.sav"
const SECRET = "Venator"
var save_file = ConfigFile.new()
var ogJewelPositions
var jewelPositions
var current_level = "Level1.tscn"
var levelNum = 1

func _ready():
	load_saves()
	#var JewelContainer = get_node_or_null("/root/Game.gd")
	#print(JewelContainer == null)
	#var jewelPositions = get_node_or_null("/root/Game/JewelContainer.gd").giveJewels()


func _unhandled_input(event):
	if event.is_action_pressed("quit"):
		if not menu:
			playText = "Continue"
			var _target = get_tree().change_scene("res://Game.tscn")
			menu = true
		else:
			var _target = get_tree().change_scene("res://Levels/" + str(current_level))
			menu = false


var fade = null
var fade_speed = 0.015

var fade_in = true
var fade_out = ""

func _physics_process(_delta):
	if lives < 1 and not GameOver:
		GameOver = true
		GameOverText = "You Died!"
		var _target = get_tree().change_scene("res://Levels/Game_Over.tscn")
		
var save_data = {
	"saves": {
		"save0": {
			"lives":10
			,"jewels":0
			,"saveState": null
			,"level": get_node_or_null("res://Levels/Level1.tscn")
			,"position": Vector2(200,200)
			,"jewelPositions": ogJewelPositions
		},
		"save1": {
			"lives": null
			,"jewels": null
			,"saveState": null
			,"level": get_node_or_null("res://Levels/Level1.tscn")
			,"position": Vector2(200,200)
			,"jewelPositions": ogJewelPositions
		},
		"save2": {
			"lives": null
			,"jewels": null
			,"saveState": null
			,"level": get_node_or_null("res://Levels/Level1.tscn")
			,"position": Vector2(200,200)
			,"jewelPositions": ogJewelPositions
		},
		"save3": {
			"lives": null
			,"jewels": null
			,"saveState": null
			,"level": get_node_or_null("res://Levels/Level1.tscn")
			,"position": Vector2(200,200)
			,"jewelPositions": ogJewelPositions
		}
	}
}

func save_game(save):
	save_data["saves"]["save" + str(save)] = {
		"lives": lives
		,"jewels": jewels
		,"saveState": saveState[save]
		,"level": current_level
		,"position": var2str(current_position)
		,"jewelPositions": var2str(jewelPositions)
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
	jewels = save_data["saves"]["save" + str(save)]["jewels"]
	saveState[save] = save_data["saves"]["save" + str(save)]["saveState"]
	current_position = str2var(save_data["saves"]["save" + str(save)]["position"])
	jewelPositions = str2var(save_data["saves"]["save" + str(save)]["jewelPositions"])
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
