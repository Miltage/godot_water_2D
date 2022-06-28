extends Node

class_name Spring

const dampening:float = 0.015
const tension:float = 0.045
const targetHeight:float = 0
const factor:float = 60

var position:Vector2
var height:float
var speed:float

func _init(pos):
	position = pos

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var x = targetHeight - height
	speed += tension * x - speed * dampening
	height += speed * delta * factor
