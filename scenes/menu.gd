extends Node3D
const WORLD = preload("res://scenes/world.tscn")
@export var debugging : bool = false
@export var transition : TransitionComponent
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_personaje_proto_interacted_menu(Name: String) -> void:
	match Name:
		"Play":
			if transition != null:
				transition.transition_out()
		"Quit":
			get_tree().quit()
