@tool
extends Node3D
class_name TransitionComponent
@export var next_scene : PackedScene
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var enable_in : bool = false
@export var enable_out : bool = true
@onready var control: Control = $Control
@export var audio : MusicComponent

	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if enable_in == true:
		transition_in()
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func transition_out(to_scene : PackedScene = next_scene):
	#control.visible = true
	if audio != null:
		audio.fade(-80.0,1.0)
	animation_player.play("tansition")
	await animation_player.animation_finished
	#control.visible = false
	get_tree().change_scene_to_packed(to_scene)
	
func transition_in():
	#control.visible = true
	animation_player.play_backwards("tansition")
