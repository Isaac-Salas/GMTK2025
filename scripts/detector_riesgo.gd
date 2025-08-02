extends Area3D
@export var player : Player
@onready var all_the_stuff : Array[RiesgoComponent]
@export var update_player : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if update_player == true:
		player.update_timer(true)
	else:
		player.update_timer(false)

func print_all():
	print("Venga: ")
	for i in all_the_stuff:
		print(i.Tipo)

func apply_to_player():
	if all_the_stuff.size() > 0:
		player.touched_obstacle = all_the_stuff[0].Tipo
		update_player = true
	else:
		player.touched_obstacle = ""
		update_player = false

func _on_area_entered(area: Area3D) -> void:
	if area is RiesgoComponent:
		all_the_stuff.append(area)
		print_all()
		apply_to_player()


func _on_area_exited(area: Area3D) -> void:
	if area is RiesgoComponent:
		all_the_stuff.pop_front()
		print_all()
		apply_to_player()
