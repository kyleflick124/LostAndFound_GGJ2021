extends "res://objects/O2Area.gd"


func _on_Area2D_body_entered(body):
	if body.has_method("lose_oxygen"):
		player = body
		player.set_in_space(true)
		$Timer.start(0.25)
		player.timer_setup()
		
	elif body.has_method("throw"):
		body.weight = 0


func _on_Area2D_body_exited(body):
	if body == player:
		$Timer.stop()
	
	elif body.has_method("throw"):
		body.weight = 9.8
