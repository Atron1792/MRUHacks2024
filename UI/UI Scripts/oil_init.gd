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
@export var SteelInit = resce.SteelInit
var danger = 0;

#GUI Resources background area element

#Ready Initilization
func _ready():
	
	get_node("CanvasLayer/HBoxContainer/Oil Text").size.x = 100
	get_node("CanvasLayer/HBoxContainer/Food Text").size.x = 100
	get_node("CanvasLayer/HBoxContainer/Population Text").size.x = 150
	get_node("CanvasLayer/HBoxContainer/Wood Text").size.x = 100
	get_node("CanvasLayer/HBoxContainer/Steel Text").size.x = 100
	#Text positioning (x,y)
	$"CanvasLayer/HBoxContainer/Oil Text".position = Vector2(100,0)
	$"CanvasLayer/HBoxContainer/Food Text".position = Vector2(200,0)
	$"CanvasLayer/HBoxContainer/Population Text".position = Vector2(320,0)
	$"CanvasLayer/HBoxContainer/Wood Text".position = Vector2(500,0)
	$"CanvasLayer/HBoxContainer/Steel Text".position = Vector2(600,0)
	
	print(OilInit)
func _process(_delta):
	stop_train()
	resource_texts()
	game_end()

func depletion_resource():
	if !($CanvasLayer/Panel.visible):
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
	$"CanvasLayer/HBoxContainer/Oil Text".add_image($"CanvasLayer/HboxContainer/Oil Text/Oil/texture")
	$"CanvasLayer/HBoxContainer/Oil Text".text = "     Oil: " + str(OilInit)
	
	$"CanvasLayer/HBoxContainer/Oil Text".add_image($"CanvasLayer/HboxContainer/Food Text/Food/texture")
	$"CanvasLayer/HBoxContainer/Food Text".text = "     Food: " + str(FoodInit)
	
	$"CanvasLayer/HBoxContainer/Oil Text".add_image($"CanvasLayer/HboxContainer/Population Text/Population/texture")
	$"CanvasLayer/HBoxContainer/Population Text".text = "     Population: " + str(PeopleInit)
	
	$"CanvasLayer/HBoxContainer/Oil Text".add_image($"CanvasLayer/HboxContainer/Wood Text/Wood/texture")
	$"CanvasLayer/HBoxContainer/Wood Text".text = "     Wood: " + str(WoodInit)
	
	$"CanvasLayer/HBoxContainer/Oil Text".add_image($"CanvasLayer/HboxContainer/Steel Text/Steel/texture")
	$"CanvasLayer/HBoxContainer/Steel Text".text = "     Steel: " + str(SteelInit)

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
	
	$CanvasLayer/Panel/Info_text.text = "You Have Stopped Leave before the people freeze\n\n Area Danger Level: " + str(danger)
	$CanvasLayer/Panel/Info_text.size = Vector2(400, 200)
	$CanvasLayer/Panel/Info_text.position = Vector2(100, 100)
	stop_manager()
 
#Stop management for resources
func stop_manager():
	$CanvasLayer/Panel/HSlider.editable = true
	$CanvasLayer/Panel/HSlider.size = Vector2(250, 100)
	$CanvasLayer/Panel/HSlider.set_max(round(PeopleInit/10))
	$CanvasLayer/Panel/HSlider.position = Vector2(150,200)
	$CanvasLayer/Panel/RichTextLabel.size.x = 250
	$CanvasLayer/Panel/RichTextLabel.position = Vector2(150, 200)
	$CanvasLayer/Panel/Button.position = Vector2(200, 300)
	$CanvasLayer/Panel/Button.size = Vector2(100, 50)
	$CanvasLayer/Panel/Button.modulate = Color(255,255,255, 0.75)

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
