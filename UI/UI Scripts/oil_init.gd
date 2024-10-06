extends Node

# Oil Initilazation Script Runs once
#Author: Phospor-cell
#Date: 2024-10-05 @ 11:11 AM
#Corrupt: 2
#______________________________

#Init variables do not change
@export var OilInit = 100
@export var FoodInit = 5
@export var PeopleInit = 10
@export var WoodInit = 0
@export var StoneInit = 0


#GUI Resources background area element

#Ready Initilization
func _ready():
	get_node("CanvasLayer/Oil Text").size.x = 100
	get_node("CanvasLayer/Food Text").size.x = 100
	get_node("CanvasLayer/Population Text").size.x = 130
	get_node("CanvasLayer/Wood Text").size.x = 100
	get_node("CanvasLayer/Stone Text").size.x = 100
	#Text positioning (x,y)
	$"CanvasLayer/Oil Text".position = Vector2(100,0)
	$"CanvasLayer/Food Text".position = Vector2(200,0)
	$"CanvasLayer/Population Text".position = Vector2(300,0)
	$"CanvasLayer/Wood Text".position = Vector2(500,0)
	$"CanvasLayer/Stone Text".position = Vector2(600,0)
	
	print(OilInit)
func _process(_delta):
	resource_texts()
	game_end()


func depletion_resource():
	if PathFollow2d.speed >= 0:
		OilInit -= 5
	elif PathFollow2d.speed <= 0:
		OilInit -=1 
	
	if OilInit == 0:
		PeopleInit -= (round(randf_range(0, 0.5)*PeopleInit))
	if FoodInit > 0:
		FoodInit -= round(PeopleInit*0.5)
	else:
		FoodInit = 0
	if FoodInit > (PeopleInit*1.25):
		PeopleInit += round(randf_range(0, 0.1)*PeopleInit)
	elif FoodInit < (PeopleInit*0.99):
		PeopleInit -= round(randf_range(0, .5)*PeopleInit)

func resource_texts():
	$"CanvasLayer/Oil Text".text = "Oil: " + str(OilInit)
	$"CanvasLayer/Food Text".text = "Food: " + str(FoodInit)
	$"CanvasLayer/Population Text".text = "Population: " + str(PeopleInit)
	$"CanvasLayer/Wood Text".text = "Wood: " + str(WoodInit)
	$"CanvasLayer/Stone Text".text = "Steel: " + str(StoneInit)

func add_Oil(Oil):
	OilInit += Oil

func add_Food(Food):
	FoodInit += Food

func add_Peps(Peps):
	PeopleInit += Peps

func add_Wood(Wood):
	WoodInit += Wood

func add_Steel(steel):
	StoneInit += steel

func _on_timer_timeout() -> void:
	depletion_resource()
	
func game_end():
	if PeopleInit <= 1:
		$"../Sprite2D/Path2D/PathFollow2D".speed = 0
