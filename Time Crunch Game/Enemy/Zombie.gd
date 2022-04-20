extends KinematicBody2D

var player = null
onready var ray = $RayCast2D
export var speed = 350
export var looking_speed = 25
var line_of_sight = false

export var looking_color = Color(0.455,0.753,0.988,0.25)
export var los_color = Color(0.988,0.753,0.455,0.5)

var points = []
const margin = 1.5

func _ready():
	position = Vector2(20,100)

func _physics_process(_delta):
	var velocity = Vector2.ZERO
	print(get_node_or_null("/root/Game/Level1"))
	player = get_node_or_null("/root/Levels/Level1/Player_Container")
	if player != null:
		ray.cast_to = ray.to_local(player.global_position)
		var c = ray.get_collider()
		line_of_sight = false
		if c and c.name == "Player":
			line_of_sight = true
		points = get_node("/root/Levels/Level1/Navigation2D").get_simple_path(get_global_position(), player.global_position, true)
		if points.size() > 1:
			var distance = points[1] - get_global_position()
			var direction = distance.normalized()
			if distance.length() > margin or points.size() > 2:
				if line_of_sight:
					velocity = direction*speed
				else:
					velocity = direction*looking_speed
			else:
				velocity = Vector2(0, 0)
			move_and_slide(velocity, Vector2(0,0))
		update()

func _draw():
	var c = looking_color
	if line_of_sight:
		c = los_color
	if points.size() > 1:
		var prev_point = get_global_position()
		for p in points:
			draw_line(p - get_global_position(), prev_point - get_global_position(), c, 2)
			prev_point = p


func _on_Area2D_body_entered(body):
	if body.name == 'Player':
		body.die()
		queue_free()

