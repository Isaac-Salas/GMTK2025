extends Node3D
@export var debugging : bool = false

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("Reset") and debugging == true:
		get_tree().reload_current_scene()


func _ready() -> void:
	SaveManager.load_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
