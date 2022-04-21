extends Node2D


onready var tween = get_node("Tween")

func driveIn():
	tween = get_node_or_null("Tween")
	if tween != null:
		tween.interpolate_property($Car, "position",$Car.position, Vector2(550, $Car.position.y), 5,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
		
func driveOut():
	tween = get_node_or_null("Tween2")
	if tween != null:
		tween.interpolate_property($Car, "position",$Car.position, Vector2($Car.position.x-2000, $Car.position.y), 8,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
		
	var wave = load("res://Enemy/FinalWave.tscn")
	add_child(wave.instance())


func _on_Timer_timeout():
	driveIn()


func _on_Tween2_tween_completed(object, key):
	$Car.next()
	$Car.queue_free()
