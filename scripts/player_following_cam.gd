extends Camera3D
@export var Player : Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Player != null :
		position.z = Player.position.z
		position.x = Player.position.x
