extends Node

# Oil Initilazation Script Runs once
#Author: Phospor-cell
#Date: 2024-10-05 @ 11:11 AM
#Corrupt: 6
#______________________________

#Init variables do not change
@export var OilInit = resce.OilInit
@export var FoodInit = resce.FoodInit
@export var PeopleInit = resce.PeopleInit
@export var WoodInit = resce.WoodInit
@export var StoneInit = resce.StoneInit


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
	stop_train()
	resource_texts()
	game_end()


func depletion_resource():
	if $"../Sprite2D/Path2D/PathFollow2D".speed > 0:
		OilInit -= 5
	elif $"../Sprite2D/Path2D/PathFollow2D".speed <= 0:
		OilInit -= 2
	if FoodInit > 0:
		FoodInit -= round(PeopleInit*0.5)
	else:
		FoodInit = 0
	if FoodInit > (PeopleInit*1.25):
		PeopleInit += 1
	elif FoodInit < (PeopleInit*0.99):
		if PeopleInit > 0:
			if PeopleInit >= 5:
				PeopleInit -= round(randf_range(0, .5)*PeopleInit)
			else:
				PeopleInit -= 1 
		else:
			PeopleInit = 0

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
	if PeopleInit <= 0 or OilInit <= 0:
		$"../Sprite2D/Path2D/PathFollow2D".speed = 0
#hours spent fixing github: Pending + 6hours

func stop_train():
	$CanvasLayer/Panel.size.x = 600
	$CanvasLayer/Panel.size.y = 400
	$CanvasLayer/Panel.position = Vector2(300, 100)
	$CanvasLayer/Panel.modulate = Color(0, 1, 1, 1)
	if $"../Sprite2D/Path2D/PathFollow2D".speed == 0:
		$CanvasLayer/Panel.visible = true
	else: 
		$CanvasLayer/Panel.visible = false
#Achivement unlocked line 100
	
