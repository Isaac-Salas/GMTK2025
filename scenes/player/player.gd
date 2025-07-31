extends CharacterBody3D
class_name Player

@export var speed = 5
#@onready var sprite = $Sprite
var input_direction : Vector2
#var colors_struck : Array[int] = [0,0]
@export var clamp_max : float = 48.0
@export var clamp_min : float = -48.0
@export var clamp_offset : float
@export var override : bool
@export var ardillas : int
@export var chicles : int

signal color_queue_updated(color_queue : Array[int])
# Getting the input inside a 2D Vector and setting the velocity accordingly
func get_input_movement(delta):
	input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#print (input_direction)
	self.velocity.x = input_direction.x * speed
	self.velocity.z = input_direction.y * speed

func _physics_process(delta):
	
	global_position.z = clamp(global_position.z, clamp_min+clamp_offset,clamp_max-clamp_offset)
	global_position.x = clamp (global_position.x, clamp_min+clamp_offset,clamp_max-clamp_offset)
	#print(global_position)
	get_input_movement(delta)
	move_and_slide()
	
