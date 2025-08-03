extends Node3D
class_name RacerComponent
@export var time_to_run : float = 20.0
@onready var path_follow_3d: PathFollow3D = $Path3D/PathFollow3D
@onready var tween : Tween
signal TweenDone()


func start(interrupt : bool = false):
	reset_anim()
	tween.tween_property(path_follow_3d, "progress_ratio", 1.0 , time_to_run)


func reset_anim():
	if tween:
		tween.kill()
	tween = create_tween()

func restart():
	path_follow_3d.progress_ratio = 0.0
	path_follow_3d.progress = 0.0
