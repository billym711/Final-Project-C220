extends Control

func _ready():
	hide() 

func _unhandled_input(event):
	if event.is_action_pressed("menu"):
		if not visible:
			show()
		else:
			get_tree().paused = false
			hide()

func _on_Restart_pressed():
	var _scene = get_tree().change_scene("res://Levels/Level" + str(1) + ".tscn")
	Global.current_position = Global.starting_position
	var player = get_node_or_null("/root/Level" + str(Global.current_level) + "/Player_Container/Player");
	if player != null:
		player.position = Global.starting_position
	Global.current_level = 1

func _on_Quit_pressed():
	get_tree().quit()

func _on_Save_pressed():
	var _scene = get_tree().change_scene("res://Save/SaveLoad.tscn")
