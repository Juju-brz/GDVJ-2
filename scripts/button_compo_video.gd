extends Control

### VARIABLES ###

static var next_id := 0

var id: int
var idtable
@export var buttonCompoVideo : Button
@export var buthide          : Button
@export var butlock          : Button
@export var CompositionVideo : Control

var mediaImport : bool = false

#Control Media
var hide : bool        = false
var lock : bool        = false


### FUNCTIONS ###

func _init():
	id = next_id
	next_id += 1

func _ready():
	EVENTS.add_button_compo_icon.connect(changeButtonIcon)
	EVENTS.delete_icon.connect(delette_icon)
	EVENTS.delete_all_media.connect(delette_all)
	EVENTS.active_change_color.connect(active_button)
	EVENTS.deactive_change_color.connect(deactive_button)
	print("button id ", id, " ", "idtable ", idtable)
	buttonCompoVideo.modulate = Color("ffffffff")

func changeButtonIcon(buttonid, texture):
	if buttonid != id:
		pass
	else:
		buttonCompoVideo.icon = texture
		buttonCompoVideo.expand_icon = true
		mediaImport = true

func _on_button_compo_video_pressed() -> void:
	EVENTS.button_compo.emit(id, idtable)

func _on_but_hide_pressed() -> void:
	if mediaImport == false:
		pass
	else:
		EVENTS.hide_media.emit(id)
		if hide == false:
			buthide.text = "UNHIDE"
			hide = true
		else:
			buthide.text = "HIDE"
			hide = false

func _on_but_lock_pressed() -> void:
	if mediaImport == false:
		pass
	else:
		EVENTS.lock_media.emit(id)
		if lock == false:
			butlock.text = "UNLOCK"
			lock = true
		else:
			butlock.text = "LOCK"
			lock = false

func _on_but_del_pressed() -> void:
	EVENTS.delete_media.emit(id)

func delette_icon(imageid):
	if id != imageid:
		pass
	else:
		buttonCompoVideo.icon = null
		mediaImport = false
		butlock.text = "LOCK"
		buthide.text = "HIDE"

func delette_all(idtableTable):
	if idtable != idtableTable:
		pass
	else:
		EVENTS.delete_media.emit(id)

func active_button(ImportId):
	if id != ImportId:
		pass
	else:
		buttonCompoVideo.modulate = Color(0.916, 0.421, 0.406, 1.0)

func deactive_button(ImportId):
	if id != ImportId:
		pass
	else:
		buttonCompoVideo.modulate = Color("ffffffff")
