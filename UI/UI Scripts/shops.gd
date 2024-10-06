extends Node



func _ready():
	var button = button.new()
	button.pressed.connect(self.)
	add_child(button)
	
#func viewhide():
#	$Control/CanvasLayer2/ItemList
