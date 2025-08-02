extends Node3D
class_name ObjectComponent
const OUTLINE = preload("res://shaders/outline.gdshader")

@export_enum("Ardilla", "Chicle", "Buff") var Tipo : String = "Ardilla"
@onready var player : Player
@export var Zona : int
@export var Numero : int
@export var Eterno : bool

@onready var can_interact : bool 
@onready var player_detect: Area3D = $PlayerDetect
@onready var sprite: Sprite3D = $Sprite
@onready var rich_text_label: RichTextLabel = $Sprite/Prompt/SubViewport/RichTextLabel

@onready var prompt_sprite: Sprite3D = $Sprite/Prompt


signal InteractedWith(Type)

func _ready() -> void:
	if player != null:
		InteractedWith.connect(player.interacted_eval)
	if Eterno == false:
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



func  _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact") and can_interact == true:
		set_and_save(Tipo, Zona, Numero)

func prompt(toggle : bool):
	match toggle:
		true:
			prompt_sprite.visible = true
		false:
			prompt_sprite.visible = false
	
		#newmat.set_shader_parameter("flickering_speed", 20)
	

func _on_player_detect_body_entered(body: Node3D) -> void:
	if body is Player:
		if Tipo != null:
			player = body
			prompt(true)
			can_interact = true


func _on_player_detect_body_exited(body: Node3D) -> void:
	if body is Player:
		if Tipo != null:
			player = null
			prompt(false)
			can_interact = false

func set_and_save(type : String, zone : int, num : int):
	var constructed : String = str(type) + str(zone) + "_" + str(num)
	SaveManager.setter(constructed,true)
	SaveManager.save_game()
	if Player != null:
		InteractedWith.emit(type)
		if Eterno == false:
			self.queue_free()
