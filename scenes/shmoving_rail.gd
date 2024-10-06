extends Node2D

@onready var anim = $AnimatedSprite2D2
@onready var anim1 = $AnimatedSprite2D3
@onready var anim2 = $AnimatedSprite2D
@onready var anim3 = $AnimatedSprite2D4
@onready var anim4 = $AnimatedSprite2D6
@onready var anim5 = $AnimatedSprite2D5
func _ready():
	anim.play("rail_animation", 2)
	anim1.play("rail_animation", 2)
	anim2.play("rail_animation", 2)
	anim3.play("rail_animation", 2)
	anim4.play("rail_animation", 2)
	anim5.play("rail_animation", 2)
func _process(delta):
	pass
