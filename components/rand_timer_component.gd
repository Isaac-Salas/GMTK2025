extends Timer
class_name RandTimer
@export var go : bool 
@export var time_range : float


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if go == true:
		start_rand(time_range)

func start_rand(t_r : float = time_range):
	print("StartingTimers")
	var rand_time = randf_range(1.0, t_r)
	start(rand_time)


func _on_timeout() -> void:
	start_rand(time_range)
