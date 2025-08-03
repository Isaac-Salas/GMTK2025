extends StaticBody3D
signal WIN()
@export var override : bool = false
@onready var area_3d: Area3D = $Area3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_player_start_race(state: bool) -> void:
	if override == false:
		match state:
			true:
				self.position.y = 0.0
				
			false:
				self.position.y = -5.0
	else:
		match state:
			true:
				area_3d.position.y = 6.0
				
			false:
				self.position.y = -5.0




func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player:
		WIN.emit()
		self.position.y = -5.0
