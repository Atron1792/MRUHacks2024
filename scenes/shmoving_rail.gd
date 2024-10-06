extends Node2D

@onready var anim = $AnimatedSprite2D2
@onready var anim1 = $AnimatedSprite2D3
@onready var anim2 = $AnimatedSprite2D
func _ready():
	anim.play("rail_animation")
	anim1.play("rail_animation")
	anim2.play("rail_animation")
func _process(delta):
	pass
