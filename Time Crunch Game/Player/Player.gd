extends KinematicBody2D

var velocity = Vector2.ZERO

var rotation_speed = 6.0
var speed = 200.0
var max_speed = 210.0
var health = 20

var Effects = null
onready var Explosion = load("res://Effects/Explosion.tscn")

onready var Bullet = load("res://Player/Bullet.tscn")
var nose = Vector2(0,-60)

func _physics_process(_delta):
	velocity = velocity + get_input()*speed
	velocity = velocity.normalized() * clamp(velocity.length(), 0, max_speed)
	velocity = move_and_slide_with_snap(velocity, Vector2.ZERO)
	velocity.x = lerp(velocity.x, 0, .5)
	velocity.y = lerp(velocity.y, 0, .5)


	if Input.is_action_just_pressed("shoot"):
		var Effects = get_node_or_null("/root/Game/Effects")
		if Effects != null:
			var bullet = Bullet.instance()
			bullet.global_position = global_position + nose.rotated(rotation)
			bullet.rotation = rotation
			Effects.add_child(bullet)

func get_input():
	var to_return = Vector2.ZERO
	if Input.is_action_pressed("forward"):
		to_return.y -= 1
	if Input.is_action_just_pressed("forward"):
		$Engine.play()
	if Input.is_action_just_released("forward"):
		$Engine.stop()
	if Input.is_action_pressed("left"):
		rotation_degrees = rotation_degrees - rotation_speed
	if Input.is_action_pressed("right"):
		rotation_degrees = rotation_degrees + rotation_speed
	return to_return.rotated(rotation)
	
func damage(d):
	health -= d
	if health <= 0:
		Global.update_lives(-1)
		Effects = get_node_or_null("/root/Game/Effects")
		if Effects != null:
			var explosion = Explosion.instance()
			Effects.add_child(explosion)
			explosion.global_position = global_position
			hide()
			yield(explosion, "animation_finished")
		queue_free()


