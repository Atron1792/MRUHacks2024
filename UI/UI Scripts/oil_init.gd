extends Node

# Oil Initilazation Script Runs once
#Author: Phospor-cell
#Date: 2024-10-05 @ 11:11 AM
#______________________________

#Init variables do not change
var OilInit = 0
var FoodInit = 0
var PeopleInit = 0
var WoodInit = 0
var StoneInit = 0


#GUI Resources background area element

#Ready Initilization
func _ready():
	$"CanvasLayer/Oil Text".text = "Oil: " + str(OilInit)
	$"CanvasLayer/Food Text".text = "Food: " + str(FoodInit)
	$"CanvasLayer/Population Text".text = "Population" + str(PeopleInit)
	$"CanvasLayer/Wood Text".text = "Wood: " + str(WoodInit)
	$"CanvasLayer/Stone Text".text = "Stone: " + str(StoneInit)
	
	print(OilInit)
