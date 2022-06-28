extends Sprite2D

var velocity = Vector2()
var targetRot:float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	transform.origin += velocity * delta
	rotation = lerp(rotation, targetRot, 0.1)

func fall(water):
	var height = water.getHeightAt(transform.origin.x) + 360
	if (transform.origin.y > height):
		water.splash(transform.origin.x, velocity.y * 0.06)
		velocity.y = (height - transform.origin.y) * 4
		
		var gradient = water.getGradientAt(transform.origin.x)
		var rot = atan2(gradient.y, gradient.x)
		targetRot = rot
		velocity.x = (targetRot) * 100
	else:
		velocity.y += 9.8
