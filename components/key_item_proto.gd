extends Node3D
class_name KeyItemComponent
@onready var player : Player
@export var FetchQuest : bool = true
@export var Zona : int
@export var Numero : int

@export_enum("Chicle") var Tipo : String = "Chicle"
@onready var prompt_text: RichTextLabel = $Sprite/Prompt/SubViewport/PromptText


@onready var prompt_sprite: Sprite3D = $Sprite/Prompt
@onready var can_interact : bool 
@onready var stick_to_player : bool
@onready var move_component: MoveComponent = $MoveComponent


signal CompleteQuest()
signal Grabed(state : bool)

func _ready() -> void:
	await SaveManager.load_game()
	var constructed = lookup()
	check_if_done(constructed)

func lookup():
	var constructed : String = str(Tipo) + str(Zona) + "_" + str(Numero)
	return constructed

func check_if_done(preconstructed : String):
	var compare = SaveManager.get(preconstructed)
	print("Checking ->", preconstructed, ": ", compare)
	if compare == true:
		self.queue_free()
		CompleteQuest.emit()


func  _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact") and can_interact == true:
		if stick_to_player == false:
			Grabed.emit(true)
	if Input.is_action_just_pressed("DropItem") and stick_to_player == true:
		Grabed.emit(false)


func _on_grabed(state: bool) -> void:
	match state:
		true:
			move_component.force_stop()
			stick_to_player = true
			prompt_text.clear()
			prompt_text.append_text("[center]Drop?[/center]")
			
		false:
			if player != null:
				move_component.force_start()
				self.global_position = player.global_position
			stick_to_player = false
			prompt_text.clear()
			prompt_text.append_text("[center]Interact?[/center]")


func prompt(toggle : bool):
	match toggle:
		true:
			prompt_sprite.visible = true
		false:
			prompt_sprite.visible = false
	
		#newmat.set_shader_parameter("flickering_speed", 20)
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match stick_to_player:
		true:
			self.global_position = player.global_position + Vector3 (0.0, 0.1 , -2.0)


func _on_player_detect_body_entered(body: Node3D) -> void:
	if FetchQuest == true:
		if body is Player:
			player = body
			can_interact = true
			prompt(true)


func _on_player_detect_body_exited(body: Node3D) -> void:
	if FetchQuest == true:
		if body is Player:
			can_interact = false
			prompt(false)
