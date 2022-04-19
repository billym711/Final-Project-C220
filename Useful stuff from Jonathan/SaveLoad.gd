extends Node2D



func _ready():
	if Global.saveState[1] == null:
		$Slot1.hint_tooltip = "No Data Saved"
		$Save1.disabled = true
		$Delete1.disabled = true
	else:
		$Slot1.hint_tooltip = Global.saveState[1]
		$Save1.disabled = false
		$Delete1.disabled = false
	if Global.saveState[2] == null:
		$Slot2.hint_tooltip = "No Data Saved"
		$Save2.disabled = true
		$Delete2.disabled = true
	else:
		$Slot2.hint_tooltip = Global.saveState[2]
		$Save2.disabled = false
		$Delete2.disabled = false
	if Global.saveState[3] == null:
		$Slot3.hint_tooltip = "No Data Saved"
		$Save3.disabled = true
		$Delete3.disabled = true
	else:
		$Slot3.hint_tooltip = Global.saveState[3]
		$Save3.disabled = false
		$Delete3.disabled = false
	

func getInfo():
	var time = OS.get_time()
	var time_return = String(time.hour) +":"+String(time.minute)+":"+String(time.second)
	return "Data Saved at " + time_return + ": \n-Level " + str(Global.levelNum) + "\n   Jewels: " + str(Global.jewels) + "\n   Lives: " + str(Global.lives)
	
func _on_Back_pressed():
	var _target = get_tree().change_scene("res://Game.tscn")


func _on_Slot1_pressed():
	if Global.saveState[1] == null:
		Global.saveState[1] = getInfo()
		Global.save_game(1)
	else:
		Global.load_game(1)
	_ready()


func _on_Slot2_pressed():
	if Global.saveState[2] == null:
		Global.saveState[2] = getInfo()
		Global.save_game(2)
	else:
		Global.load_game(2)
	_ready()


func _on_Slot3_pressed():
	if Global.saveState[3] == null:
		Global.saveState[3] = getInfo()
		Global.save_game(3)
	else:
		Global.load_game(3)
	_ready()


func _on_Save1_pressed():
	Global.saveState[1] = getInfo()
	Global.save_game(1)
	_ready()


func _on_Save2_pressed():
	Global.saveState[2] = getInfo()
	Global.save_game(2)
	_ready()


func _on_Save3_pressed():
	Global.saveState[3] = getInfo()
	Global.save_game(3)
	_ready()


func _on_Delete1_pressed():
	Global.delete_save(1)
	_ready()

func _on_Delete2_pressed():
	Global.delete_save(2)
	_ready()

func _on_Delete3_pressed():
	Global.delete_save(3)
	_ready()
