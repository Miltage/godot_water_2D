extends Node2D

const spread:float = 0.08
const waterDistance:float = 30
const waterDepth:float = 240
const waterTopColor:Color = Color("#097ae3", 0.8)
const waterBottomColor:Color = Color("#002a52")

var springs:Array

# Called when the node enters the scene tree for the first time.
func _ready():
	springs = []
	
	for i in 40:
		var s = Spring.new(Vector2(i * waterDistance, 360))
		springs.append(s)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for spring in springs:
		spring._process(delta)
		
	var lDeltas = []
	var rDeltas = []

	for spring in springs:
		lDeltas.append(0)
		rDeltas.append(0)

	for j in 8:
		for i in springs.size():
			if (i > 0):
				lDeltas[i] = spread * (springs[i].height - springs[i - 1].height)
				springs[i - 1].speed += lDeltas[i]
			if (i < springs.size() - 1):
				rDeltas[i] = spread * (springs[i].height - springs[i + 1].height)
				springs[i + 1].speed += rDeltas[i]
		
		for i in springs.size():
			if (i > 0):
				springs[i - 1].height += lDeltas[i]
			if (i < springs.size() - 1):
				springs[i + 1].height += rDeltas[i]
	
	update()

func _draw():
	for i in range(1, springs.size() - 1):
		var points = PackedVector2Array()
		points.append_array([
			springs[i].position + Vector2(-waterDistance, springs[i - 1].height), 
			springs[i].position + Vector2(0, springs[i].height), 
			springs[i].position + Vector2(0, waterDepth), 
			springs[i].position + Vector2(-waterDistance, waterDepth)
		])
		draw_polygon(points, [waterTopColor, waterTopColor, waterBottomColor, waterBottomColor])

func getHeightAt(x):
	var index = floor(x / waterDistance)
	return springs[index].height
	
func getGradientAt(x):
	var index = floor(x / waterDistance)
	return Vector2(waterDistance, springs[index + 1].height) - Vector2(0, springs[index].height)

func splash(x, force):
	var index = floor(x / waterDistance)
	springs[index].speed = force
