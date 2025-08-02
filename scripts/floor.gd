extends StaticBody3D
class_name Floor
@onready var race_barrier: StaticBody3D = $RaceBarrier

func up_barrier():
	race_barrier.position = Vector3.ZERO
func low_barrier():
	race_barrier.position = Vector3(0.0, -7.0, 0.0)
