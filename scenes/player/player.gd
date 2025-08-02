extends CharacterBody3D
class_name Player

@export var speed : float = 5.0
@export var sprint_speed : float = 10.0
#@onready var sprite = $Sprite
var input_direction : Vector2
#var colors_struck : Array[int] = [0,0]
@export var clamp_max : float = 48.0
@export var clamp_min : float = -48.0
@export var clamp_offset : float
@export var override : bool = false
@export var ardillas : int
@export var chicles : int
@export var reset_contadores : bool
@export var duracion_timer : float = 2.0
@export var todo_estado : Array[String]
@export var overlays_on : bool = true
@export var bilboard_sprite : bool = false

@onready var overlays: Control = $Overlays
@onready var ardillas_count: RichTextLabel = $Overlays/VBoxContainer/HBoxContainer/ArdillasCount
@onready var chicles_count: RichTextLabel = $Overlays/VBoxContainer/HBoxContainer/ChiclesCount
@onready var timer: Timer = $Timer
@onready var progress_bar: ProgressBar = $Overlays/VBoxContainer/ProgressBar
@onready var sprite_animations: AnimationPlayer = $Sprite/SpriteAnimations

@onready var sprite: Sprite3D = $Sprite
@onready var estado_display: RichTextLabel = $Overlays/VBoxContainer/EstadoDisplay

@onready var touched_obstacle : String 
@onready var unlocked_habilities : Array


signal MoveState(state_name : String)



func _ready() -> void:
	timer.start(duracion_timer)
	if override == false:
		SaveManager.load_game()
		set_values()
		update_counts()
	else:
		update_override()
	if reset_contadores == true:
		reset_counts()
	if overlays_on == true:
		overlays.visible = true
	else:
		overlays.visible= false
	if bilboard_sprite == true:
		sprite.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	else:
		sprite.billboard = BaseMaterial3D.BILLBOARD_DISABLED
	




func _physics_process(delta):
	
	global_position.z = clamp(global_position.z, clamp_min+clamp_offset,clamp_max-clamp_offset)
	global_position.x = clamp (global_position.x, clamp_min+clamp_offset,clamp_max-clamp_offset)
	#print(global_position)
	move_and_slide()
	get_input_movement()
	eval_moving()
	

func update_timer(go : bool):
	progress_bar.max_value = duracion_timer
	progress_bar.value = timer.time_left
	
	match go:
		true:
			if timer.is_stopped() == true or timer.is_paused() == true:
				timer.paused = false
		false:
			if timer.is_stopped() == false or timer.is_paused() == false:
				timer.paused = true



func get_input_movement():
	input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if touched_obstacle == "":
		if Input.is_action_pressed("run"):
			self.velocity.x = input_direction.x * sprint_speed
			self.velocity.z = input_direction.y * sprint_speed
		else:
			self.velocity.x = input_direction.x * speed
			self.velocity.z = input_direction.y * speed
			

	else:
		match touched_obstacle:
			"Escalar":
				check_abilities(1)
			"Agua":
				check_abilities(2)
					
		

func check_abilities(index_to_check : int):
	unlocked_habilities = [
		SaveManager.Habilidad1_1, 
		SaveManager.Habilidad2_1,
		SaveManager.Habilidad3_1, 
		SaveManager.Habilidad4_1]
	
	if unlocked_habilities[index_to_check] == false:
		throw_player_back()
	else:
		throw_player_back(true)


func throw_player_back(soft : bool = false, force : float = 2.0, ):
	match soft:
		true:
			self.velocity.x = input_direction.x * (speed - force)
			self.velocity.z = input_direction.y * (speed - force)
		false:
			self.velocity.x = input_direction.x * speed - force
			self.velocity.z = input_direction.y * speed - force


func eval_moving ():
	if input_direction != Vector2.ZERO and touched_obstacle == "":
		#Moving
		update_timer(true)
		
		if Input.is_action_pressed("run"):
			MoveState.emit("Corriendo")
		else:
			MoveState.emit("Caminando")
		
	elif touched_obstacle == "":
		#Stoping
		update_timer(false)
		MoveState.emit("Idle")
	elif input_direction != Vector2.ZERO:
		update_timer(true)
		match touched_obstacle:
			"Escalar":
				MoveState.emit("Escalando")
			"Agua":
				pass
	



func interacted_eval(interacted_with : String):
	if interacted_with == "Ardilla":
		SaveManager.setter("Ardillas_TOTAL", SaveManager.Ardillas_TOTAL + 1)
		ardillas += 1
		SaveManager.save_game()
		update_counts()
	if interacted_with == "Chicle":
		SaveManager.setter("Chicles_TOTAL", SaveManager.Chicles_TOTAL + 1)
		chicles += 1
		SaveManager.save_game()
		update_counts()

func update_override():
	SaveManager.Ardillas_TOTAL = ardillas 
	SaveManager.Chicles_TOTAL = chicles
	SaveManager.save_game()
	ardillas_count.clear()
	ardillas_count.append_text("X " + str(ardillas))
	chicles_count.clear()
	chicles_count.append_text("X " + str(chicles))
	
func set_values():
	ardillas = SaveManager.Ardillas_TOTAL 
	chicles = SaveManager.Chicles_TOTAL

func update_counts():
	ardillas_count.clear()
	ardillas_count.append_text("X " + str(ardillas))
	chicles_count.clear()
	chicles_count.append_text("X " + str(chicles))
	
func reset_counts():
	SaveManager.setter("Ardillas_TOTAL", 0)
	SaveManager.setter("Chicles_TOTAL", 0)
	SaveManager.save_game()
	set_values()
	update_counts()



func _on_timer_timeout() -> void:
	chicles -= 1
	if chicles == 0:
		ardillas -= 1
		chicles = SaveManager.Chicles_TOTAL
		print(SaveManager.Chicles_TOTAL)
	if ardillas == 0:
		print("Se acaba el dia")
		set_values()
	update_counts()


func _on_move_state(state_name : String) -> void:
	
	match state_name:
		"Caminando":
			sprite_animations.speed_scale = 1.0
			sprite_animations.play("walking")
			update_state_text("WALKING")
		"Corriendo":
			sprite_animations.speed_scale = 2.0
			sprite_animations.play("walking")
			update_state_text("RUNNING")
		"Escalando":
			sprite_animations.play("walking")
		"Idle":
			sprite_animations.play("idle")
			idle_sprite()
				

func update_state_text(text:String):
	estado_display.clear()
	estado_display.append_text("[center]" + text)

func idle_sprite():
	sprite.position = Vector3.ZERO
	sprite.position.y = 0.2
	sprite.rotation_degrees = Vector3.ZERO
	sprite.rotation_degrees.x = -90
	sprite_animations.play("idle")
