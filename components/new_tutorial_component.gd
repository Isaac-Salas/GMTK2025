extends Node3D
@export var active : bool
@export var player : Player
@export var player_tuto_spot : Marker3D
@onready var primera_parte: DialogComponent = $UI/PrimeraParte
@onready var segunda_parte: DialogComponent = $UI/SegundaParte
@onready var ui: Control = $UI
@onready var dr_kring: PersonajeComponent = $"../Personajes/Dr_Kring"

@export var doctor_spot :Marker3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if active == true:
		if player != null:
			if player_tuto_spot != null:
				player.global_position = player_tuto_spot.global_position
			ui.visible = true
			primera_parte.InputEnable = true
			primera_parte.Timerstart = true
			player.overlays_on = false
			player.override = false
			SaveManager.reset_progress()
			get_tree().paused = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match primera_parte.linecount:
		0:
			pass
