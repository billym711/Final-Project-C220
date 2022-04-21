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
		get_parent().driveOut()
		if Global.current_level != 3:
			body.visible = false
			body.takeInput = false
		
func next():
	print(get_tree().get_current_scene().get_name())
	if get_tree().get_current_scene().get_name() == "Level1":
		var scene = get_tree().change_scene("res://Levels/Level2.tscn")
	if get_tree().get_current_scene().get_name() == "Level2":
		var scene = get_tree().change_scene("res://Levels/Level3.tscn")
	if get_tree().get_current_scene().get_name() == "Level3":
		Global.damage += Global.damage_upgrades
		Global.update_health(Global.armor)
		Global.update_time(100)
		$Area2D.monitoring = false
		return
		#var scene = get_tree().change_scene("res://UI/End_Game.tscn")
	Global.damage += Global.damage_upgrades
	Global.update_health(Global.armor)
	Global.damage_upgrades = 0
	Global.armor = 0
	Global.current_level += 1
	Global.time = 60
	Global.current_position = Global.starting_position
