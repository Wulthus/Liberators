extends Camera2D

var props = {
	"min_zoom": Vector2(2.0, 2.0),
	"max_zoom": Vector2(0.5, 0.5),
	"step": Vector2(0.1, 0.1)
}
	

func _process(_delta):
	
	if Input.is_action_just_released("zoom_in"):
		var currentZoom = $".".get_zoom()
		if (
			currentZoom.x < props.min_zoom.x ||
			currentZoom.y < props.min_zoom.y
			):
			$".".set_zoom(currentZoom + props.step)
	
	if Input.is_action_just_released("zoom_out"):
		var currentZoom = $".".get_zoom()
		if (
			currentZoom.x > props.max_zoom.x ||
			currentZoom.y > props.max_zoom.y
			):
			$".".set_zoom(currentZoom - props.step)

