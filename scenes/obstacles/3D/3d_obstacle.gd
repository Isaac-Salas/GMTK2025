extends RigidBody3D
class_name ObstacleTriDi


func _on_body_entered(body: Node) -> void:
	if body is Player:
		print("HittingPlayer!!!")
		body._on_timer_timeout()
	


func _on_visible_on_screen_notifier_3d_screen_entered() -> void:
	pass # Replace with function body.


func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	self.queue_free()
