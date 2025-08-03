extends Node3D
class_name MoveComponent
@export var active : bool = true
@export var target : Node3D
@export var time_to_move : float = 2.0
@export var tween_time : float = 1.0
@export var movement_range : float = 5.0
@export var clamp_range : float = 37.0
@export var sprite_animations : SpriteAnimationComponent
@onready var move_timer: Timer = $MoveTimer


func _ready() -> void:
	pass

func animate_moving(target : Node3D, time: float = 1.0, range_om : float = 5.0):
	var tween : Tween = create_tween()
	var new_vector : Vector3 = target.global_position + Vector3(randf_range(-range_om, range_om) ,0.0, randf_range(-range_om, range_om))
	new_vector = new_vector.clamp(Vector3(-clamp_range, 0.0, -clamp_range), Vector3(clamp_range, 0.0, clamp_range))
	tween.tween_property(target, "global_position", new_vector , time)
	await tween.finished
	sprite_animations.play("AnimLibrary/idle")


func _on_timer_timeout() -> void:
	animate_moving(target, tween_time, movement_range)
	sprite_animations.play("AnimLibrary/walking")


func _on_visible_on_screen_notifier_3d_screen_entered() -> void:
	if active == true:
		move_timer.start(time_to_move)


func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	if active == true:
		move_timer.stop()
