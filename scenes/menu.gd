extends Node3D
const WORLD = preload("res://scenes/world.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_personaje_proto_interacted_menu(Name: String) -> void:
	match Name:
		"Play":
			get_tree().change_scene_to_packed(WORLD)
		"Quit":
			get_tree().quit()
