extends Node3D
class_name TutorialComponent
@export var transition : TransitionComponent
@export var active : bool
@export var player : Player
@export var house_marker : Marker3D
@export var tuto_cientifico_spot : Marker3D
@export var verdadero_scient : PersonajeComponent
@export var skip_lines : bool 
@onready var personaje_proto: PersonajeComponent = $Personaje_proto
@onready var personaje_proto_2: PersonajeComponent = $Personaje_proto2
@onready var dialog_box_2: DialogComponent = $Personaje_proto2/UIStuff/DialogBox
@onready var quest_complete_dialog_2: DialogComponent = $Personaje_proto2/UIStuff/QuestCompleteDialog



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SaveManager.load_game()
	print("TEsting savefile TUTORIAL: ",SaveManager.Tutorial_Completo )
	#if SaveManager.Tutorial_Completo == false:
		#active = true
	if player != null and active == true:
		player.override = false
		player.unlock_all_abilities = false
		player.overlays_on = false
		if house_marker != null:
			player.global_position = house_marker.global_position
	elif active == false:
		nuke_tutorial()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_dialog_box_dialog_done() -> void:
	if active == true:
		player.go_to_race()
		player.overlays.visible = true
		personaje_proto.force_dialog = false
		if tuto_cientifico_spot != null:
			personaje_proto.global_position = tuto_cientifico_spot.global_position
		await transition.animation_player.animation_finished
		if skip_lines == true:
			var get_size = personaje_proto.quest_complete_dialog.Dialog.size() - 1
			personaje_proto.start_dialog(personaje_proto.quest_complete_dialog, get_size)
		else:
			personaje_proto.start_dialog(personaje_proto.quest_complete_dialog)


func _on_player_start_race(state: bool) -> void:
	if active == true:
		match state:
			true:
				pass
			false:
				personaje_proto.queue_free()
				print("Failed during tuto :( ")
				if transition != null:
					transition.TransitionDone.connect(tutorial_second_part)

func tutorial_second_part():
	if active == true:
		connect("dialog_box_2.DialogDone",ultima)
		personaje_proto_2.visible = true
		if skip_lines == true:
			var get_size = personaje_proto_2.dialog_box.Dialog.size() - 1
			personaje_proto_2.start_dialog(personaje_proto_2.dialog_box, get_size)
		else:
			personaje_proto_2.start_dialog(personaje_proto_2.dialog_box)
		get_tree().paused = true
		


func ultima() -> void:
	if active == true:
		print("Test?", personaje_proto_2.quest_completed)
		personaje_proto_2.start_dialog(personaje_proto_2.quest_complete_dialog)
 

func nuke_tutorial():
	print("Nukeando...")
	self.queue_free()
	verdadero_scient.visible = true
	verdadero_scient.move_component.force_start()
	verdadero_scient.interact_player = true
	

func listo() -> void:
	SaveManager.setter("Tutorial_Completo", true)
	SaveManager.save_game()
	nuke_tutorial()
