extends AnimationPlayer
class_name DayAnimations


func day_end():
	get_tree().paused = true
	play("Night&Day")
	await animation_finished
	get_tree().paused = false


func _on_player_day_end() -> void:
	day_end()
