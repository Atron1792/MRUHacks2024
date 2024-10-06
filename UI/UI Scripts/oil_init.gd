extends Node

# Oil Initilazation Script Runs once
#Author: Phospor-cell
#Date: 2024-10-05 @ 11:11 AM
#Corrupt: 9
#hours spent fixing github: Pending + 6hours
#______________________________
#Init variables do not change
@export var OilInit = resce.OilInit
@export var FoodInit = resce.FoodInit
@export var PeopleInit = resce.PeopleInit
@export var WoodInit = resce.WoodInit
@export var StoneInit = resce.StoneInit

var fraction_oil = 1
var fraction_food = 1

var danger = 0;

#upgrade vars
var upg_oil = 0
var upg_food = 0
var upg_peps = 0
var upg_wood = 0
var upg_steel = 0

#GUI Resources background area element

#Ready Initilization
func _ready():
	get_node("CanvasLayer/Oil Text").size.x = 100
	get_node("CanvasLayer/Food Text").size.x = 100
	get_node("CanvasLayer/Population Text").size.x = 130
	get_node("CanvasLayer/Wood Text").size.x = 100
	get_node("CanvasLayer/Stone Text").size.x = 100
	$CanvasLayer/Panel/RichTextLabel.text = "Send Scavengers: 0"
	#Text positioning (x,y)
	$"CanvasLayer/Oil Text".position = Vector2(100,0)
	$"CanvasLayer/Food Text".position = Vector2(200,0)
	$"CanvasLayer/Population Text".position = Vector2(300,0)
	$"CanvasLayer/Wood Text".position = Vector2(500,0)
	$"CanvasLayer/Stone Text".position = Vector2(600,0)
	
	#rationing init
	$CanvasLayer/Container/HSlider3.size = Vector2(50, 25)
	$CanvasLayer/Container/HSlider3.position = Vector2(10, 50)
	$CanvasLayer/Container/HSlider3.set_max(4)
	$CanvasLayer/Container/HSlider3.set_min(1)
	$CanvasLayer/Container/HSlider3.set_value_no_signal(4)
	
	$CanvasLayer/Container/HSlider2.size = Vector2(50, 25)
	$CanvasLayer/Container/HSlider2.position = Vector2(10, 100)
	$CanvasLayer/Container/HSlider2.set_max(4)
	$CanvasLayer/Container/HSlider2.set_min(1)
	$CanvasLayer/Container/HSlider2.set_value_no_signal(4)
	
	$CanvasLayer/Container/FractionOil.text = str(1)
	$CanvasLayer/Container/FractionOil.size = Vector2(50, 25)
	$CanvasLayer/Container/FractionOil.position = Vector2(10, 30)
	
	
	$CanvasLayer/Container/RichTextLabel2.text = str(1)
	$CanvasLayer/Container/RichTextLabel2.size = Vector2(50, 25)
	$CanvasLayer/Container/RichTextLabel2.position = Vector2(10, 80)
	upgrades_init()


func _on_h_slider_3_drag_ended(value_changed: bool) -> void:
	fraction_oil = $CanvasLayer/Container/HSlider3.value/4
	$CanvasLayer/Container/FractionOil.text = str(fraction_oil)



func _on_h_slider_2_drag_ended(value_changed: bool) -> void:
	fraction_food = $CanvasLayer/Container/HSlider2.value/4
	$CanvasLayer/Container/RichTextLabel2.text = str(fraction_food)

func _process(_delta):
	stop_train()
	resource_texts()
	game_end()
	if FoodInit < 0:
		FoodInit = 0
	if Input.is_key_pressed(KEY_SPACE):
		danger = round(abs($"../Sprite2D/Path2D/PathFollow2D".position.y)+($"../Sprite2D/Path2D/PathFollow2D".position.x)/100)

func depletion_resource():
	if !($CanvasLayer/Panel.visible):
		if $"../Sprite2D/Path2D/PathFollow2D".speed > 0:
			OilInit -= round(5*fraction_oil)+1
		elif $"../Sprite2D/Path2D/PathFollow2D".speed <= 0:
			OilInit -= round(2*fraction_oil)+1
		if FoodInit > 0:
			FoodInit -= round(PeopleInit*fraction_food)
		else:
			FoodInit = 0
		if FoodInit > PeopleInit and (fraction_food > 0.50):
			PeopleInit += 1
			
		elif FoodInit < (PeopleInit*0.95) or fraction_food <= 0.5:
			if PeopleInit > 0:
				if PeopleInit >= 5 and fraction_food < 0.75 and FoodInit < (PeopleInit*0.5):
					PeopleInit -= round(randf_range(0, .5)*PeopleInit)
				elif fraction_food == 0.75 or PeopleInit < 5:
					PeopleInit -= 1 
				elif FoodInit < (PeopleInit*0.90) and PeopleInit > 5:
					PeopleInit -= 3
			else:
				PeopleInit = round(randf_range(0, .1)*PeopleInit)

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
	$CanvasLayer/Panel/Stop_text.text = "GAME OVER"
	$CanvasLayer/Panel/Info_text.text = "The People Have Frozen"
	
#Stop management UI
func stop_train():
	$CanvasLayer/Panel.size.x = 600
	$CanvasLayer/Panel.size.y = 400
	$CanvasLayer/Panel.position = Vector2(300, 100) 
	$CanvasLayer/Panel.modulate = Color(0, 1, 1, 1)
	$CanvasLayer/Panel.modulate.a = 1.60
	if $"../Sprite2D/Path2D/PathFollow2D".speed == 0:
		$CanvasLayer/Panel.visible = true
	else: 
		$CanvasLayer/Panel.visible = false
#Achivement unlocked line 100
	$CanvasLayer/Panel/Stop_text.text = "Gathering"
	#$CanvasLayer/Panel/Stop_text.scale.x = 3
	#$CanvasLayer/Panel/Stop_text.scale.y = 3
	$CanvasLayer/Panel/Stop_text.size.x = 500
	$CanvasLayer/Panel/Stop_text.position.x = 175
	
	$CanvasLayer/Panel/Info_text.text = "You Have Stopped Leave before the people freeze\n\n Area Danger Level: " + str(danger)
	$CanvasLayer/Panel/Info_text.size = Vector2(400, 200)
	$CanvasLayer/Panel/Info_text.position = Vector2(100, 100)
	stop_manager()

#Stop management for resources
func stop_manager():
	$CanvasLayer/Panel/HSlider.editable = true
	$CanvasLayer/Panel/HSlider.size = Vector2(250, 100)
	$CanvasLayer/Panel/HSlider.set_max(round(PeopleInit/10))
	$CanvasLayer/Panel/HSlider.position = Vector2(150,225)
	$CanvasLayer/Panel/RichTextLabel.size.x = 250
	$CanvasLayer/Panel/RichTextLabel.position = Vector2(150, 175)
	$CanvasLayer/Panel/Button.position = Vector2(225, 300)
	$CanvasLayer/Panel/Button.size = Vector2(100, 50)
	$CanvasLayer/Panel/Button.modulate = Color(255,255,255, 0.75)

func _on_h_slider_drag_ended(value_changed: bool) -> void:
	$CanvasLayer/Panel/RichTextLabel.text = "Send Scavengers: " + str($CanvasLayer/Panel/HSlider.value)




func _on_button_pressed() -> void:
	$CanvasLayer/Panel.visible = false
	var oiladded = round(abs(danger-20*($CanvasLayer/Panel/HSlider.value/10)*randi_range(0,2))) 
	var foodadded = round(danger*($CanvasLayer/Panel/HSlider.value/10)*randi_range(0,2))
	var pepsjoin = round(danger*randf_range(-1, 0) + $CanvasLayer/Panel/HSlider.value*danger*randf_range(0, 0.25))
	var woodadded = round(danger*randf_range(0,1)*$CanvasLayer/Panel/HSlider.value)
	var steeladded = round(danger*randf_range(0,0.5)*$CanvasLayer/Panel/HSlider.value)
	
	if PeopleInit >= 9999:
		pepsjoin = 0
	$CanvasLayer/Panel/RichTextLabel.text = "Scavengers Found: \nOil: " + str(oiladded) + "		Food: " + str(foodadded) + "	People: " + str(pepsjoin) + "	Wood: " +str(woodadded) + "		Steel: " + str(steeladded)
	
	$CanvasLayer/Panel/RichTextLabel.size = Vector2(300,300)
	$CanvasLayer/Panel.visible = true
	add_Oil(oiladded)
	add_Peps(pepsjoin)
	add_Food(foodadded)
	add_Wood(woodadded)
	add_Steel(steeladded)
	


func upgrades_init():
	$Container/Panel/upg1.size = Vector2(400,300)
	$Container/Panel/upg1.scale = Vector2(2,2)
	$Container/Panel/upg1.position = Vector2(0, 10)
	$Container/Panel/upg1.modulate = Color(0,0,0, 3)
	$Container/Panel.modulate = Color(255,229,204,0.5)
	$Container/Panel.size = Vector2(400, 500)
	$Container/Panel.position = Vector2(2000,100)
	$Container/Panel/upg1.text = "Oil Upgrades: 0\n\n Food Upgrades: 0\n\n Population Upgrades: 0\n\n Wood Upgrades: 0\n\n Steel Upgrades: 0\n"
	
