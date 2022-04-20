extends Control

func _ready():
	$Label.text = "Thanks for playing! Your final score was " + str(Global.score) + "."

func _on_Play_again_pressed():
	Global.ready()
	var _scene = get_tree().change_scene("res://Levels/Level1.tscn")

func _on_Quit_pressed():
	get_tree().quit()
