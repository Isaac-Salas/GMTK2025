extends Control
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var transition : TransitionComponent
const MENU = preload("res://scenes/Menu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_goal_barrier_win() -> void:
	animation_player.play("WIN!!!")
	await animation_player.animation_finished
	transition.transition_out(MENU)
	
