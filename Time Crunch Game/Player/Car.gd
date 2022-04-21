extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_Area2D_body_entered(body):
	if body.name == "Player":
		var nextLevel = str(Global.current_level + 1)
		var scene = get_tree().change_scene("res://Levels/Level" + nextLevel + ".tscn")
		Global.current_level += 1
