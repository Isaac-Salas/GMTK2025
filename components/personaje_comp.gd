extends Node3D
class_name PersonajeComponent

@onready var can_interact : bool 
@onready var prompt_sprite: Sprite3D = $Sprite/Prompt


@onready var move_timer: Timer = $MoveTimer

@export var normal_dialog : PackedStringArray
@export var quest_end : PackedStringArray

@export var character_name : String
@export var timeout_to_move : float = 2.0
@export var move_duration : float = 1.0
@export var range_of_movement : float = 5.0
@export var quest_item_needed : KeyItemComponent
@export var quest_item_in_hand : bool
@export var quest_completed : bool  
@export var menu_behaviour : bool = false
@export var clamp_range : float = 37.0
@export var interact_player : bool = true

@onready var sprite_animations: AnimationPlayer = $Sprite/SpriteAnimations
@onready var texture_rect: TextureRect = $UIStuff/TextureRect
@onready var dialog_box: DialogComponent = $UIStuff/DialogBox
@onready var quest_complete_dialog: DialogComponent = $UIStuff/QuestCompleteDialog
@onready var name_text: RichTextLabel = $UIStuff/NameText
@onready var close_timer: Timer = $UIStuff/CloseTimer
@onready var ui_stuff: Control = $UIStuff


signal InteractedMenu(Name : String)

func _ready() -> void: 
	if character_name != null:
		name_text.append_text(character_name + ":")
	if quest_item_needed != null:
		quest_item_needed.Grabed.connect(grab_toggle)
		quest_item_needed.CompleteQuest.connect(quest_completer)
	if normal_dialog != null:
		dialog_box.Dialog = normal_dialog
	if quest_end != null:
		quest_complete_dialog.Dialog = quest_end

func grab_toggle(state : bool):
	match  state:
		true:
			quest_item_in_hand = true
		false:
			quest_item_in_hand = false

func  _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact") and can_interact == true:
		if menu_behaviour == false:
			if quest_item_in_hand == true and quest_completed == false:
				start_dialog(quest_complete_dialog)
			elif quest_completed == true:
				start_dialog(quest_complete_dialog)
			else:
				start_dialog(dialog_box)
		else:
			InteractedMenu.emit(character_name)

func start_dialog(dialog_comp : DialogComponent):
	
	ui_stuff.visible = true
	dialog_comp.clearcenter()
	dialog_comp.linecount = 0
	dialog_comp.timer.start()
	dialog_comp.InputEnable = true
	get_tree().paused = true

func _on_player_detect_body_entered(body: Node3D) -> void:
	if body is Player:
		if interact_player == true:
			prompt(true)
			can_interact = true

func _on_player_detect_body_exited(body: Node3D) -> void:
	if body is Player:
		if interact_player == true:
			prompt(false)
			can_interact = false

func prompt(toggle : bool):
	match toggle:
		true:
			prompt_sprite.visible = true
		false:
			prompt_sprite.visible = false
	


func _on_visible_on_screen_notifier_3d_screen_entered() -> void:
	move_timer.start(timeout_to_move)


func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	move_timer.stop()


func _on_timer_timeout() -> void:
	animate_moving(self, move_duration, range_of_movement)
	sprite_animations.play("AnimLibrary/walking")
	

func animate_moving(target : Node3D, time: float = 1.0, range_om : float = 5.0 ):
	var tween : Tween = create_tween()
	var new_vector : Vector3 = target.global_position + Vector3(randf_range(-range_om, range_om) ,0.0, randf_range(-range_om, range_om))
	new_vector = new_vector.clamp(Vector3(-clamp_range, 0.0, -clamp_range), Vector3(clamp_range, 0.0, clamp_range))
	tween.tween_property(target, "global_position", new_vector , time)
	await tween.finished
	sprite_animations.play("AnimLibrary/idle")


func _on_dialog_box_dialog_done() -> void:
	if quest_item_in_hand == true and quest_completed == false:
		dialog_closer(quest_complete_dialog, true)
		quest_completer()
	elif quest_completed == true:
		dialog_closer(quest_complete_dialog, false)
	else:
		dialog_closer(dialog_box, false)
	

func quest_completer():
	quest_completed = true
	set_and_save(quest_item_needed.Tipo,quest_item_needed.Zona, quest_item_needed.Numero)
	quest_item_needed.queue_free()


func dialog_closer(dialog : DialogComponent , drop_item : bool):
	close_timer.start(0.2)
	await close_timer.timeout
	ui_stuff.visible = false
	get_tree().paused = false
	dialog.clearcenter()
	dialog.linecount = 0
	dialog.timer.stop()
	if drop_item == true:
		print("Drop CHICLE!!!!")


func set_and_save(type : String, zone : int, num : int):
	var constructed : String = str(type) + str(zone) + "_" + str(num)
	SaveManager.setter(constructed, true)
	SaveManager.save_game()
