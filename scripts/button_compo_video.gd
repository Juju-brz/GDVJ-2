extends Control

static var next_id := 0

var id: int
@export var buttonCompoVideo : Button
#signal action_pressed(id: int)

func _init():
	id = next_id
	next_id += 1

func _ready():
	#pressed.connect(func(): EVENTS.button_compo.emit(id))
	print("button id", id)
	EVENTS.add_button_compo_icon.connect(test)


func test(texture):
	print("change this f*** icon")
	print(texture)
	#buttonCompoVideo.icon = preload("res://media/jujuLogo.png")
	buttonCompoVideo.icon = texture
	buttonCompoVideo.expand_icon = true


func _on_button_compo_video_pressed() -> void:
	EVENTS.button_compo.emit(id)
