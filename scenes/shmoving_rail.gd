extends Node2D

@onready var anim = $AnimatedSprite2D2
@onready var anim1 = $AnimatedSprite2D3
@onready var anim2 = $AnimatedSprite2D
@onready var anim3 = $AnimatedSprite2D4
@onready var anim4 = $AnimatedSprite2D6
@onready var anim5 = $AnimatedSprite2D5
var velocity = 3
func _ready():
	anim.play("rail_animation", 3)
	anim1.play("rail_animation", 3)
	anim2.play("rail_animation", 3)
	anim3.play("rail_animation", 3)
	anim4.play("rail_animation", 3)
	anim5.play("rail_animation", 3)
func _process(_delta):
	if ($"../MiniMap/Sprite2D/Path2D/PathFollow2D".is_slowing_down || $"../MiniMap/Sprite2D/Path2D/PathFollow2D".is_stopped) and velocity >0:
		velocity = velocity - 0.01
	if ($"../MiniMap/Sprite2D/Path2D/PathFollow2D".is_speeding_up || $"../MiniMap/Sprite2D/Path2D/PathFollow2D".speed == 0.01) and velocity < 3:
		velocity = velocity + 0.01
	anim.play("rail_animation", velocity)
	anim1.play("rail_animation", velocity)
	anim2.play("rail_animation", velocity)
	anim3.play("rail_animation", velocity)
	anim4.play("rail_animation", velocity)
	anim5.play("rail_animation", velocity)
