extends Node

# Oil Initilazation Script Runs once
#Author: Phospor-cell
#Date: 2024-10-05 @ 11:11 AM
#Corrupt: 6
#hours spent fixing github: Pending + 6hours
#______________________________
#Init variables do not change
@export var OilInit = resce.OilInit
@export var FoodInit = resce.FoodInit
@export var PeopleInit = resce.PeopleInit
@export var WoodInit = resce.WoodInit

var fraction_oil = 1
var fraction_food = 1

var SteelInit = resce.SteelInit
var danger = 0;

#GUI Resources background area element

#Ready Initilization
func _ready():
	get_node("CanvasLayer/Oil Text").size.x = 200
	get_node("CanvasLayer/Food Text").size.x = 100
	get_node("CanvasLayer/Population Text").size.x = 150
	get_node("CanvasLayer/Wood Text").size.x = 100
	get_node("CanvasLayer/Steel Text").size.x = 100
	$CanvasLayer/Panel/RichTextLabel.text = "Send Scavengers: 0"
	
	#Text positioning (x,y)
	$"CanvasLayer/Oil Text".position = Vector2(104,28)
	$"CanvasLayer/Food Text".position = Vector2(352,28)
	$"CanvasLayer/Population Text".position = Vector2(656,28)
	$"CanvasLayer/Wood Text".position = Vector2(904,18)
	$"CanvasLayer/Steel Text".position = Vector2(904,44)

	
	#rationing init
	$CanvasLayer/Container/HSlider3.size = Vector2(50, 25)
	$CanvasLayer/Container/HSlider3.position = Vector2(260,44)
	$CanvasLayer/Container/HSlider3.set_max(4)
	$CanvasLayer/Container/HSlider3.set_min(1)
	$CanvasLayer/Container/HSlider3.set_value_no_signal(4)
	
	$CanvasLayer/Container/HSlider2.size = Vector2(50, 25)
	$CanvasLayer/Container/HSlider2.position = Vector2(520,44)
	$CanvasLayer/Container/HSlider2.set_max(4)
	$CanvasLayer/Container/HSlider2.set_min(1)
	$CanvasLayer/Container/HSlider2.set_value_no_signal(4)
	
	$CanvasLayer/Container/FractionOil.text = "Ration Oil: " + str(1)
	$CanvasLayer/Container/FractionOil.size = Vector2(150, 25)
	$CanvasLayer/Container/FractionOil.position = Vector2(125,44)
	
	$CanvasLayer/Container/RichTextLabel2.text = "Ration Food: " + str(1)
	$CanvasLayer/Container/RichTextLabel2.size = Vector2(150, 25)
	$CanvasLayer/Container/RichTextLabel2.position = Vector2(370,44)


func _on_h_slider_3_drag_ended(_value_changed: bool) -> void:
	fraction_oil = $CanvasLayer/Container/HSlider3.value/4
	$CanvasLayer/Container/FractionOil.text = "Ration Oil: " + str(fraction_oil)



func _on_h_slider_2_drag_ended(_value_changed: bool) -> void:
	fraction_food = $CanvasLayer/Container/HSlider2.value/4
	$CanvasLayer/Container/RichTextLabel2.text = "Ration Food: " + str(fraction_food)

func _process(_delta):
	stop_train()
	resource_texts()
	game_end()
	if FoodInit < 0:
		FoodInit = 0

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
	#$"CanvasLayer/Oil Text".add_image($"CanvasLayer/Oil Text/Oil/texture")
	$"CanvasLayer/Oil Text".text = "     Oil: " + str(OilInit)
	
	#$"CanvasLayer/Oil Text".add_image($"CanvasLayer/Food Text/Food/texture")
	$"CanvasLayer/Food Text".text = "     Food: " + str(FoodInit)
	
	#$"CanvasLayer/Oil Text".add_image($"CanvasLayer/Population Text/Population/texture")
	$"CanvasLayer/Population Text".text = "     Population: " + str(PeopleInit)
	
	#$"CanvasLayer/Oil Text".add_image($"CanvasLayer/Wood Text/Wood/texture")
	$"CanvasLayer/Wood Text".text = "     Wood: " + str(WoodInit)
	
	#$"CanvasLayer/Oil Text".add_image($"CanvasLayer/Steel Text/Steel/texture")
	$"CanvasLayer/Steel Text".text = "     Steel: " + str(SteelInit)

func add_Oil(Oil):
	OilInit += Oil

func add_Food(Food):
	FoodInit += Food

func add_Peps(Peps):
	PeopleInit += Peps

func add_Wood(Wood):
	WoodInit += Wood

func add_Steel(steel):
	SteelInit += steel

func _on_timer_timeout() -> void:
	depletion_resource()
	
func game_end():
	if PeopleInit <= 0 or OilInit <= 0:
		$"../Sprite2D/Path2D/PathFollow2D".speed = 0
		
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
	
	$CanvasLayer/Panel/Info_text.text = "You have stopped, leave before the people freeze\n\n Area Danger Level: " + str(danger)
	$CanvasLayer/Panel/Info_text.size = Vector2(400, 200)
	$CanvasLayer/Panel/Info_text.position = Vector2(100, 100)
	stop_manager()
 
#Stop management for resources
func stop_manager():
	$CanvasLayer/Panel/HSlider.editable = true
	$CanvasLayer/Panel/HSlider.size = Vector2(275, 75)
	$CanvasLayer/Panel/HSlider.set_max(round(PeopleInit/10))
	$CanvasLayer/Panel/HSlider.position = Vector2(120,290)
	
	$CanvasLayer/Panel/RichTextLabel.size.x = 250
	$CanvasLayer/Panel/RichTextLabel.position = Vector2(150, 200)
	
	$CanvasLayer/Panel/Button.position = Vector2(425, 300)
	$CanvasLayer/Panel/Button.size = Vector2(100, 50)
	$CanvasLayer/Panel/Button.modulate = Color(255,255,255, 0.75)
	$CanvasLayer/Panel/Button.text = "Send Forward"

func _on_h_slider_drag_ended(_value_changed: bool) -> void:
	$CanvasLayer/Panel/RichTextLabel.text = "Send Scavengers: " + str($CanvasLayer/Panel/HSlider.value)

func _on_button_pressed() -> void:
	$CanvasLayer/Panel.visible = false

	
	var foodadded = round((randi_range(0, 50)) * ($CanvasLayer/Panel/HSlider.value / 10) * ($"../Sprite2D/Path2D/PathFollow2D".position.y / 200) + absi(($"../Sprite2D/Path2D/PathFollow2D".position.x - 500) / 200))
	var pepsjoin = round((randi_range(0, 20)) * ($CanvasLayer/Panel/HSlider.value / 10) * ($"../Sprite2D/Path2D/PathFollow2D".position.y / 200) + (($"../Sprite2D/Path2D/PathFollow2D".position.x - 200) / 200) * randi_range(-1, 1))
	var oiladded = round((randi_range(0, 50)) * ($CanvasLayer/Panel/HSlider.value / 10) * ($"../Sprite2D/Path2D/PathFollow2D".position.y / 200) + absi((500 - $"../Sprite2D/Path2D/PathFollow2D".position.x) / 200))
	
	if PeopleInit >= 9999:
		pepsjoin = 0
		
	$CanvasLayer/Panel/RichTextLabel.text = "Scavengers Found: \nOil: " + str(oiladded) + "\nFood: " + str(foodadded) + "\nPeople: " + str(pepsjoin)
	$CanvasLayer/Panel/RichTextLabel.size = Vector2(300,300)
	$CanvasLayer/Panel.visible = true
	
	add_Oil(oiladded)
	add_Peps(pepsjoin)
	add_Food(foodadded)
	
func random_event() -> void:
	var eventChanceCalculator = randi()%50
	if eventChanceCalculator == 0:
		$Events/RichTextLabel.add_text(
			"Emergency!!! There is an avalanche coming down ahead of us on the track! We won’t be able to stop safely in time and according to our calculations it will hit the back carriage while passing, commander what do we do?"
		)
		pass
	elif eventChanceCalculator == 1:
		$Events/RichTextLabel.add_text(
			"Commander!!! We have caught someone breaking into our food supply room trying to steal some food. Should we exile the man? The family states that if we exile the man that they threaten they would join the man. Commander, what should we do?"
		)
		pass
	elif eventChanceCalculator == 2:
		$Events/RichTextLabel.add_text(
			"Good news commander! We have spotted a depot that still has some supplies! However the building itself is in a poor condition. We bet we can get one crate (around 30 of either food, wood, oil) out safely but the other 2 creates might be difficult to remove and cause the building to collapse."
		)
		pass
	elif eventChanceCalculator == 3:
		$Events/RichTextLabel.add_text(
			"Good news commander! We have spotted a small colony still alive! They seem to be poorly brought together and look like they won't last very long. We have some supplies but is it enough to keep us alive? I know this is very controversial but I can gather a few people to go over and steal some of their supplies. What should I do, commander?"
		)
		pass
	elif eventChanceCalculator == 4:
		$Events/RichTextLabel.add_text(
			"Bad news commander, while traveling through our most recent city some of the track was damaged causing the wheels of our train to be damaged. It is not serious but it is causing some of the storage compartments to shake. If this continues something might damage some of our supplies. What should we do commander?"
		)
		pass
	pass
func on_button_pressed(_Scenario, _option) -> void:
	pass
