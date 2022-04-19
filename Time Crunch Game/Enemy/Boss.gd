extends KinematicBody2D

var y_positions = [100,150,200,500,550]
var initial_position = Vector2.ZERO
var direction = Vector2(1,0)
onready var Asteroid = load("res://Asteroid/Asteroid.tscn")
var asteroids = [Vector2(0,-30),Vector2(30,30),Vector2(-30,30)]
var health = 10
var small_speed = 2.0

var Effects = null
onready var Bullet = load("res://Enemy/Bullet.tscn")
onready var Explosion = load("res://Effects/Explosion.tscn")

func _ready():
	initial_position.x = -100
	initial_position.y = 20
	position = initial_position

func _physics_process(_delta):
	position += direction
	position.y = initial_position.y
	position.x = wrapf(position.x, 0, Global.VP.x)
	if position.y >= Global.VP.y/2 - 50:
		position.y = Global.VP.y/2 - 50
	if position.y <= 0:
		position.y = 0

func damage(d):
	health -= d
	if health <= 0:
		Global.update_score(1000)
		collision_layer = 0
		var Boss_Container = get_node_or_null("/root/Game/Asteroid_Container")
		if Boss_Container != null:
			for s in asteroids:
				var asteroid = Asteroid.instance()
				var dir = randf()*2*PI
				var i = Vector2(0,randf()*small_speed).rotated(dir)
				Boss_Container.call_deferred("add_child", asteroid)
				asteroid.position = position + s.rotated(dir)
				asteroid.velocity = i
		Effects = get_node_or_null("/root/Game/Effects")
		if Effects != null:
			var explosion = Explosion.instance()
			Effects.add_child(explosion)
			explosion.global_position = global_position
		queue_free()


func _on_Area2D_body_exited(body):
	if body.name == "Player":
		body.damage(100)
		damage(100)


func _on_Timer_timeout():
	var Player = get_node_or_null("/root/Game/Player_Container/Player")
	Effects = get_node_or_null("/root/Game/Effects")
	if Player != null and Effects != null:
		var bullet1 = Bullet.instance()
		var bullet2 = Bullet.instance()
		var bullet3 = Bullet.instance()
		bullet1.global_position = global_position + Vector2(0,-40)
		bullet2.global_position = global_position + Vector2(0,-40)
		bullet3.global_position = global_position + Vector2(0,-40)
		bullet1.rotation = 4.2
		bullet2.rotation = PI
		bullet3.rotation = 2.5
		Effects.add_child(bullet1)
		Effects.add_child(bullet2)
		Effects.add_child(bullet3)
