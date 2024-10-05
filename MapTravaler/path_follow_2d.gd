extends PathFollow2D

var speed = 0.05
var is_speeding_up = false
var is_slowing_down = false
var is_stopped = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_key_pressed(KEY_SPACE):
		if !is_slowing_down && !is_speeding_up && !is_stopped:
			speed = speed - 0.001
			is_slowing_down = true
		elif is_stopped:
			is_stopped = false
			is_speeding_up = true
	if is_slowing_down:
		if speed <= 0:
			speed = 0
			is_slowing_down = false
			is_stopped = true
		else:
			speed = speed - 0.001
	if is_speeding_up:
		if speed >= 0.05:
			speed = 0.1
			is_speeding_up = false
		else:
			speed = speed + 0.001
	progress_ratio += delta * speed
