extends Button

static var next_id := 0

var id: int

signal action_pressed(id: int)

func _init():
	id = next_id
	next_id += 1

func _ready():
	pressed.connect(func(): EVENTS.button_compo.emit(id))
	print("button id", id)
