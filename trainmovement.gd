extends Node2D

var formulax= 0
var sinFunnyFunctionVelocity = 0.03
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ($"../MiniMap/Sprite2D/Path2D/PathFollow2D".is_slowing_down || $"../MiniMap/Sprite2D/Path2D/PathFollow2D".is_stopped) and sinFunnyFunctionVelocity >0:
		sinFunnyFunctionVelocity = sinFunnyFunctionVelocity - 0.001
	if $"../MiniMap/Sprite2D/Path2D/PathFollow2D".is_speeding_up && sinFunnyFunctionVelocity < 0.03:
		sinFunnyFunctionVelocity = sinFunnyFunctionVelocity + 0.001
	formulax = formulax +sinFunnyFunctionVelocity
	print(formulax)
	if(formulax < 4):
		position.y = (-1)*(pow(formulax -2, 2)) + 4
	elif(formulax >= 4):
		position.y = pow(formulax - 6, 2)-4
	if(formulax >= 8):
		formulax = 0
	
