extends Node3D
class_name TimeSpawnerComponent
@onready var spawner_component: SpawnerComponent = $SpawnerComponent
@onready var rand_timer_comp: RandTimer = $RandTimerComp





func _on_rand_timer_comp_timeout() -> void:
	spawner_component.spawn3d()
