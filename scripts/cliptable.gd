extends HBoxContainer

### VARIABLES ###

const ButtonComp = preload("res://UI/button_compo_video.tscn")
#var buttonArray : Array
@export var compoVideo : Control
var idtable

### FUNCTIONS ###

func _ready() -> void:
	EVENTS.compotable.connect(cliptable_id)
	idtable = compoVideo.idtable
	#print("truc", idtable)
	
	for i in range(4):
		create_buttonComp()

func _on_add_clip_but_pressed() -> void:
	create_buttonComp()


func create_buttonComp():
	var b = ButtonComp.instantiate()
	b.idtable = idtable
	add_child(b)

func cliptable_id():
	print("cliptable id")
	pass
