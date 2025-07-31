extends Node3D
class_name ObjectComponent
@export_enum("Habilidad","Ardilla", "Chicle", "Buff") var Tipo
@onready var player_detect: Area3D = $PlayerDetect


func _on_player_detect_body_entered(body: Node3D) -> void:
	if body is Player:
		match  Tipo:
			"Ardilla":
				
