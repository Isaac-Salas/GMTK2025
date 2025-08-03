extends Node3D
@onready var agua: RacerComponent = $Agua
@onready var aire: RacerComponent = $Aire
@onready var piedra: RacerComponent = $Piedra
@export var transition: TransitionComponent
@export var scientist : PersonajeComponent
@export var scientist_spot : Marker3D
@export var scientist_return : Marker3D
@onready var allspawners : Array[TimeSpawnerComponent]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var buffer = get_children()
	for item in buffer:
		if item is TimeSpawnerComponent:
			allspawners.append(item)
	print(allspawners)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func activate_all_timers(array : Array[TimeSpawnerComponent]):
	for spawner in array:
		spawner.rand_timer_comp.start_rand()

func deactivate_all_timers(array : Array[TimeSpawnerComponent]):
	for spawner in array:
		spawner.rand_timer_comp.stop()

func _on_player_start_race(state: bool) -> void:
	match state:
		true:
			activate_all_timers(allspawners)
			activate(agua)
			activate(aire)
			activate(piedra)
			scientist.start_dialog(scientist.quest_complete_dialog)
			scientist.move_component.force_stop()
			scientist.interact_player = false
			scientist.global_position = scientist_spot.global_position
		false:
			deactivate_all_timers(allspawners)
			deactivate(agua)
			deactivate(aire)
			deactivate(piedra)
			scientist.global_position = scientist_return.global_position
			scientist.interact_player = true
			scientist.move_component.force_start()

func activate(racer : RacerComponent):
	racer.visible = true
	racer.start()

func deactivate(racer : RacerComponent):
	racer.visible = false
	racer.reset_anim()
	racer.restart()
