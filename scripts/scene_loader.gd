
@tool
extends Node
class_name SceneManager
var properties = GlobalPreloader.get_script().get_script_property_list()
var all_scenes : Array[PackedScene]

func transition(to_scene : PackedScene):
	get_tree().change_scene_to_packed(to_scene)

func _ready() -> void:
	var all_scenes
	for i in properties:
		var item : PackedScene = GlobalPreloader.get(i.name)
		if item != null: 
			all_scenes.append(item)
			
			
	print(all_scenes)
