extends Node2D

var sinFunnyFunction = 0
var sinFunnyFunctionVelocity = 0.03
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	position.y = position.y + (sin(sinFunnyFunction)*.4)
	sinFunnyFunction += sinFunnyFunctionVelocity
	if sinFunnyFunction == 360:
		sinFunnyFunction = 0
