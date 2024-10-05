extends Node

# Oil Initilazation Script Runs once
#Author: Phospor-cell
#Date: 2024-10-05 @ 11:11 AM
#______________________________

#Init variables do not change
<<<<<<< HEAD
var OilInit = 0
var FoodInit = 0
var PeopleInit = 0
=======
var OilInit = 50
var FoodInit = 75
var PeopleInit = 100
>>>>>>> dev
var WoodInit = 0
var StoneInit = 0


#GUI Resources background area element

#Ready Initilization
func _ready():
<<<<<<< HEAD
	$"CanvasLayer/Oil Text".text = "Oil: " + str(OilInit)
	$"CanvasLayer/Food Text".text = "Food: " + str(FoodInit)
	$"CanvasLayer/Population Text".text = "Population" + str(PeopleInit)
	$"CanvasLayer/Wood Text".text = "Wood: " + str(WoodInit)
	$"CanvasLayer/Stone Text".text = "Stone: " + str(StoneInit)
	
	print(OilInit)
=======
	$"CanvasLayer/Timer".start()
	
	$"CanvasLayer/Oil Text".size.x = 100
	$"CanvasLayer/Food Text".size.x = 100
	$"CanvasLayer/Population Text".size.x = 130
	$"CanvasLayer/Wood Text".size.x = 100
	$"CanvasLayer/Stone Text".size.x = 100
	
	#Text positioning (x,y)
	$"CanvasLayer/Oil Text".position = Vector2(100,0)
	$"CanvasLayer/Food Text".position = Vector2(200,0)
	$"CanvasLayer/Population Text".position = Vector2(300,0)
	$"CanvasLayer/Wood Text".position = Vector2(500,0)
	$"CanvasLayer/Stone Text".position = Vector2(600,0)

func _process(delta):
	resource_texts()


func depletion_resource():
	OilInit -= 5
	FoodInit -= PeopleInit*0.5
	if FoodInit > (PeopleInit*1.25):
		PeopleInit += 1
	elif FoodInit < (PeopleInit*0.99):
		PeopleInit -= randi_range(0, .5)*PeopleInit

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
	
>>>>>>> dev
