extends Node3D
class_name ObjectComponent
@export_enum("Habilidad","Ardilla", "Chicle", "Buff") var Tipo : String = "Ardilla"
@export var Zona : int
@export var Numero : int
@onready var player_detect: Area3D = $PlayerDetect


func _on_player_detect_body_entered(body: Node3D) -> void:
	if body is Player:
		if Tipo != null:
			set_and_save(Tipo, Zona, Numero)
		
				

func set_and_save(type : String, zone : int, num : int):
	var constructed : String = str(type) + str(zone) + "_" + str(num)
	SaveManager.setter(constructed,true)
	SaveManager.save_game()
	
