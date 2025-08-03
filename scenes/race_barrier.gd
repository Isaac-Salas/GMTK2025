extends StaticBody3D
class_name RaceBarrier

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_player_start_race(state: bool) -> void:
	match state:
		true:
			position = Vector3.ZERO
		false:
			position = Vector3(0.0, -7.0, 0.0)
