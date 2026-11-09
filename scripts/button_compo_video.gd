extends Control

static var next_id := 0

var id: int
@export var buttonCompoVideo : Button
#signal action_pressed(id: int)
@export var buthide : Button
@export var butlock : Button
var hide : bool = false
var lock : bool = false

func _init():
	id = next_id
	next_id += 1

func _ready():
	#pressed.connect(func(): EVENTS.button_compo.emit(id))
	print("button id", id)
	EVENTS.add_button_compo_icon.connect(changeButtonIcon)


func changeButtonIcon(buttonid, texture):
	if buttonid != id:
		pass
	else:
		buttonCompoVideo.icon = texture
		buttonCompoVideo.expand_icon = true

func _on_button_compo_video_pressed() -> void:
	EVENTS.button_compo.emit(id)


func _on_but_hide_pressed() -> void:
	EVENTS.hide_media.emit(id)
	if hide == false:
		buthide.text = "UNHIDE"
		hide = true
	else:
		buthide.text = "HIDE"
		hide = false


func _on_but_lock_pressed() -> void:
	EVENTS.lock_media.emit(id)
	if lock == false:
		butlock.text = "UNLOCK"
		lock = true
	else:
		butlock.text = "LOCK"
		lock = false
