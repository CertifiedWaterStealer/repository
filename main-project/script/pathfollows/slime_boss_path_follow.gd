extends PathFollow2D

var speed = 0.05

var paused = false

var current_pause = 0

var pause_points = [0.04, 0.078, 0.46]

func _process(delta: float) -> void:
	if paused == false:
		progress_ratio += speed * delta
		if current_pause < pause_points.size():
			if progress_ratio >= pause_points[current_pause]:
				pause_boss()

func pause_boss() -> void:
	paused = true
	await get_tree().create_timer(2.0).timeout
	current_pause += 1
	paused = false
