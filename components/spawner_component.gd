extends Node3D
class_name SpawnerComponent
@export var will_spawn : PackedScene
@export var position_reference : Node3D
@export var spawn_offset_range : float

func spawn_obj_comp(zone : int , num : int):
	var buffer = will_spawn
	var instance : ObjectComponent = buffer.instantiate()
	var root = get_parent().get_tree().current_scene
	instance.Zona = zone
	instance.Numero = num
	var VectorOffset : Vector3 =  Vector3(randf_range(-spawn_offset_range, spawn_offset_range), 0.0,randf_range(-spawn_offset_range, spawn_offset_range))
	root.add_child(instance)
	instance.global_position = position_reference.global_position + VectorOffset

func spawn3d(amount : int = 1):
	for times in amount:
		var instance : ObstacleTriDi = will_spawn.instantiate()
		var root = get_parent().get_tree().current_scene
		var VectorOffset : Vector3 =  Vector3(randf_range(-spawn_offset_range, spawn_offset_range), 0.0,randf_range(-spawn_offset_range, spawn_offset_range))
		instance.rotation_degrees = Vector3(randf_range(-20.0,20.0),randf_range(-20.0,20.0),randf_range(-20.0,20.0))
		root.add_child(instance)
		instance.global_position = position_reference.global_position + VectorOffset
		
