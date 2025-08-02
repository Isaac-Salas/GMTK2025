extends Node3D
class_name PersonajeComponent

@onready var can_interact : bool 
@onready var prompt_sprite: Sprite3D = $Sprite/Prompt


@onready var move_timer: Timer = $MoveTimer

@export var timeout_to_move : float = 2.0
@export var move_duration : float = 1.0
@export var range_of_movement : float = 5.0
@export var quest_giver : bool

@onready var sprite_animations: AnimationPlayer = $Sprite/SpriteAnimations
@onready var dialog_box: DialogComponent = $DialogBox



func  _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact") and can_interact == true:
		dialog_box.timer.start()
		dialog_box.InputEnable = true
		get_tree().paused = true

func _on_player_detect_body_entered(body: Node3D) -> void:
	if body is Player:
		prompt(true)
		can_interact = true

func _on_player_detect_body_exited(body: Node3D) -> void:
	if body is Player:
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
	new_vector = new_vector.clamp(Vector3(-37.0, 0.0, -37.0), Vector3(37.0, 0.0, 37.0), )
	tween.tween_property(target, "global_position", new_vector , time)
	await tween.finished
	sprite_animations.play("AnimLibrary/idle")


func _on_dialog_box_dialog_done() -> void:
	get_tree().paused = false
	dialog_box.clearcenter()
	dialog_box.linecount = 0
	dialog_box.timer.stop()
