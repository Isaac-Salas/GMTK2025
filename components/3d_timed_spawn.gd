extends Node3D
class_name TimeSpawnerComponent
@onready var spawner_component: SpawnerComponent = $SpawnerComponent
@onready var rand_timer_comp: RandTimer = $RandTimerComp
@onready var obstacle_array : Array
const BALL = preload("res://scenes/obstacles/3D/ball.tscn")
const BOX = preload("res://scenes/obstacles/3D/Box.tscn")
const FISH_2 = preload("res://scenes/obstacles/3D/Fish2.tscn")
const FISH = preload("res://scenes/obstacles/3D/Fish.tscn")
const SHOVEL = preload("res://scenes/obstacles/3D/Shovel.tscn")
const SPIKEBALL = preload("res://scenes/obstacles/3D/Spikeball.tscn")
const TREE = preload("res://scenes/obstacles/3D/Tree.tscn")

func ready():
	obstacle_array.append(BALL)
	obstacle_array.append(BOX)
	obstacle_array.append(FISH_2)
	obstacle_array.append(FISH)
	obstacle_array.append(SHOVEL)
	obstacle_array.append(SPIKEBALL)
	obstacle_array.append(TREE)
	obstacle_array.shuffle()



func _on_rand_timer_comp_timeout() -> void:
	obstacle_array.shuffle()
	spawner_component.will_spawn = obstacle_array[1]
	spawner_component.spawn3d()
