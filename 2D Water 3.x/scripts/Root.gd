extends Node2D

func _process(delta):
	$Ducky.fall($Water)
	$Ducky2.fall($Water)

func _input(event):
	if (event is InputEventMouseButton && event.button_index == BUTTON_LEFT && event.pressed):
		$Water.splash(event.position.x, 120)
