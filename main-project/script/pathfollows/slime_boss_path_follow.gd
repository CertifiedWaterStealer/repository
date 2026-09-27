extends PathFollow2D

# Stores the speed as 0.05
var speed = 0.05

# makes the variable instantly equal to false
var paused = false

#  An int stording the amount in the array below it. 
var current_pause: int = 0

# An array showing the different points in the path 2d of the slime boss.
var pause_points: Array = [0.04, 0.078, 0.46]

# Will constantly check if this function can be ran.
func _process(delta: float) -> void:
	if paused == false:
		progress_ratio += speed * delta
		if current_pause < pause_points.size():
			if progress_ratio >= pause_points[current_pause]:
				pause_boss()

# A func plusing the current pause by one, making the array go to the next point and then 
# the process will check and then the func will pause it for 2 seconds. 
func pause_boss() -> void:
	paused = true
	await get_tree().create_timer(2.0).timeout
	current_pause += 1
	paused = false
