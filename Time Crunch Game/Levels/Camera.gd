extends Camera2D


func _physics_process(_delta):
	var vtrans = get_canvas_transform()
	var top_left = -vtrans.get_origin() / vtrans.get_scale()
	$Fade.rect_global_position = top_left
	$UI/Level/Title.text = "Level: " + str(Global.current_level)
