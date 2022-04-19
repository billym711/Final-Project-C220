extends KinematicBody2D

var health = 1
var velocity = Vector2.ZERO
onready var Bullet = load("res://Enemy/Bullet.tscn")
var Effects = null
onready var Explosion = load("res://Effects/Explosion.tscn")


func _physics_process(_delta):
	position += velocity
	position.x = wrapf(position.x,0,Global.VP.x)
	if position.y >= Global.VP.y/2 - 50:
		position.y = Global.VP.y/2 - 50
		velocity.y = velocity.y * -1
	if position.y <= 0:
		position.y = 0
		velocity.y = velocity.y * -1
		
func damage(d):
	health -= d
	if health <= 0:
		Global.update_score(200)
		Effects = get_node_or_null("/root/Game/Effects")
		if Effects != null:
			var explosion = Explosion.instance()
			Effects.add_child(explosion)
			explosion.global_position = global_position
		queue_free()
		
func _on_Timer_timeout():
	var Player = get_node_or_null("/root/Game/Player_Container/Player")
	Effects = get_node_or_null("/root/Game/Effects")
	if Player != null and Effects != null:
		var bullet1 = Bullet.instance()
		bullet1.global_position = global_position + Vector2(0, 0)
		bullet1.rotation += PI
		Effects.add_child(bullet1)
