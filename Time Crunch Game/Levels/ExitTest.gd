extends Area2D

func _on_Area2D_body_entered(body):
	Global.current_position = Global.starting_position
	body.position = Global.current_position
	var nextLevel = str(Global.current_level + 1)
	var scene = get_tree().change_scene("res://Levels/Level" + nextLevel + ".tscn")
	Global.current_level += 1
