extends KinematicBody2D

var velocity = Vector2.ZERO

var rotation_speed = 6.0
var speed = 200.0
var max_speed = 210.0
var health = Global.health

var Effects = null
var nose = Vector2(0,-30)



func _physics_process(_delta):
	velocity = velocity + get_input()*speed
	velocity = velocity.normalized() * clamp(velocity.length(), 0, max_speed)
	velocity = move_and_slide_with_snap(velocity, Vector2.ZERO)
	velocity.x = lerp(velocity.x, 0, .5)
	velocity.y = lerp(velocity.y, 0, .5)


	if Input.is_action_just_pressed("shoot"):
		var Effects = get_node_or_null("../../Effects")
		var Bullet = load("res://Player/Bullet.tscn")
		if Effects != null:
			Global.zombieTarget = get_node("../Player")
			var bullet = Bullet.instance()
			bullet.global_position = global_position + nose.rotated(rotation)
			bullet.rotation = rotation
			Effects.add_child(bullet)
			$Player_Shot.play()
			$Timer.start()
			$Timer2.start()

func get_input():
	var to_return = Vector2.ZERO
	if Input.is_action_pressed("forward"):
		to_return.y -= 1
		$Sprite.play()
	if Input.is_action_just_pressed("forward"):
		$Engine.play()
	if Input.is_action_just_released("forward"):
		$Engine.stop()
		$Sprite.stop()
	if Input.is_action_pressed("left"):
		rotation_degrees = rotation_degrees - rotation_speed
	if Input.is_action_pressed("right"):
		rotation_degrees = rotation_degrees + rotation_speed
	return to_return.rotated(rotation)
	
func damage(d):
	health -= d
	Global.update_health(-1)
	if health <= 0:
		Global.current_position = Global.starting_position
		Global.update_lives(-1)
		Global.update_health(20)
		queue_free()




func _on_Timer2_timeout():
	$Player_Shot.stop()


func _on_Timer_timeout():
	Global.zombieTarget = null
	Global.canSave = true
