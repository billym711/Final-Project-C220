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
	Global.reset()
	var _scene = get_tree().change_scene("res://Game.tscn")

func _on_Quit_pressed():
	get_tree().quit()

func _on_Save_pressed():
	var _scene = get_tree().change_scene("res://Save/SaveLoad.tscn")
