extends HBoxContainer


const ButtonComp = preload("res://UI/button_compo_video.tscn")
#var buttonArray : Array
@export var compoVideo : Control
var idtable



func _ready() -> void:
	EVENTS.compotable.connect(cliptable_id)
	idtable = compoVideo.idtable
	print("truc", idtable)
	
	for i in range(4):
		create_buttonComp()

func _on_add_clip_but_pressed() -> void:
	create_buttonComp()
	#print(ButtonComp)
	#buttonArray.append(b)
	#print(buttonArray)

func create_buttonComp():
	var b = ButtonComp.instantiate()
	b.idtable = idtable
	#print(b.idtable )
	#print(idtable)
	add_child(b)

func cliptable_id():
	pass

#func _on_del_clip_but_pressed() -> void:
	#buttonArray.pop_back()
