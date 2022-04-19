extends KinematicBody2D

var velocity = Vector2.ZERO
var Effects = null
var small_speed = 3.0
var initial_speed = 3.0
var health = 1
onready var Bullet = load("res://Enemy/Bullet.tscn")
onready var Asteroid_small = load("res://Asteroid/Asteroid_small.tscn")
var small_asteroids = [Vector2(0,-30),Vector2(30,30),Vector2(-30,30)]

func _ready():
	velocity = Vector2(0,initial_speed*randf()).rotated(PI*2*randf())

func _physics_process(_delta):
	position = position + velocity
	position.x = wrapf(position.x, 0, Global.VP.x)
	if position.y >= Global.VP.y/2 - 50:
		position.y = Global.VP.y/2 - 50
		velocity.y = velocity.y * -1
	if position.y <= 0:
		position.y = 0
		velocity.y = velocity.y * -1


func damage(d):
	health -= d
	if health <= 0:
		Global.update_score(100)
		collision_layer = 0
		var Asteroid_Container = get_node_or_null("/root/Game/Asteroid_Container")
		if Asteroid_Container != null:
			for s in small_asteroids:
				var asteroid_small = Asteroid_small.instance()
				var dir = randf()*2*PI
				var i = Vector2(0,randf()*small_speed).rotated(dir)
				Asteroid_Container.call_deferred("add_child", asteroid_small)
				asteroid_small.position = position + s.rotated(dir)
				asteroid_small.velocity = i
		queue_free()
		
func _on_Timer_timeout():
	var Player = get_node_or_null("/root/Game/Player_Container/Player")
	Effects = get_node_or_null("/root/Game/Effects")
	if Player != null and Effects != null:
		var bullet1 = Bullet.instance()
		var bullet2 = Bullet.instance()
		bullet1.global_position = global_position + Vector2(20, 0)
		bullet2.global_position = global_position + Vector2(-20, 0)
		bullet1.rotation += PI
		bullet2.rotation += PI
		Effects.add_child(bullet1)
		Effects.add_child(bullet2)
