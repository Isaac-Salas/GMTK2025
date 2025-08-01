extends Node3D
class_name RiesgoComponent
@export_enum("Agua","Hoyo", "Escalar") var Tipo : String = "Escalar"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player:
		body.touched_obstacle = Tipo
		print("Player entered", Tipo)



func _on_area_3d_body_exited(body: Node3D) -> void:
	if body is Player:
		body.touched_obstacle = ""
		print("Player exited", Tipo)
