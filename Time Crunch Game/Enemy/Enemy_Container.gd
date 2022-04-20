extends Node2D

onready var Zombie = load("res://Enemy/Zombie.tscn")

func _physics_process(_delta):
	if not has_node("Zombie"):
		var zombie = Zombie.instance()
		add_child(zombie)
		zombie.name = 'Zombie'
