extends Control

var numberanim : Array
var animplay = false

var looptime : int
var playlist = false

var stop = false
@export var window : Window
var idtable


func _ready() -> void:
	EVENTS.add_id_media.connect(add_id_array)
	EVENTS.delete_media.connect(delete_id_array)
	EVENTS.anim_finish.connect(animation_finish)
	#window.always_on_top = true
	print(idtable, " CompoTable")

func add_id_array(id, tableid):
	if idtable != tableid:
		pass
	else:
		var d = id
		if d in numberanim:
			pass 
		else:
			numberanim.append(id)
			numberanim = quicksort(numberanim)
			print("anim import ","id", numberanim)

func delete_id_array(id):
	numberanim.erase(id)
	print("anim delette ","id", numberanim)

func playlist_on():
	if numberanim.is_empty():
		print("CLIP EMPTY")
		pass
	else:
		while stop == false:
			EVENTS.anim_stop.emit(idtable)
			for i in numberanim:
				print(i)
				EVENTS.anim_play.emit(i, idtable)
				await EVENTS.anim_finish
			animplay = false

func animation_finish(idtableImport):
	if idtable != idtableImport:
		pass
	else:
		animplay = true

## REORGANIZE ARRAY ANIM ##
func quicksort(list: Array):
	if list.size() <= 1: 
		return list  
	  
	var pivot = list[0] #WTF !!!??
	  
	var little = []  
	var big = []
	#print("pivot", pivot)
	
	for number in list:  
		if number < pivot:  
			little.append(number)  
		if number > pivot:  
			big.append(number)  
	
	return quicksort(little) + [pivot] + quicksort(big)

func _on_line_edit_text_submitted(new_text: String) -> void:
	#GLOBAL.loop = new_text.to_int()
	looptime = new_text.to_int()
	EVENTS.loop_time.emit(looptime, idtable)

func _on_clip_play_but_pressed() -> void:
	stop = false
	playlist_on()

func _on_stop_play_but_pressed() -> void:
	stop = true
	EVENTS.exit_playlist.emit(idtable)

func _on_del_all_but_pressed() -> void:
	if idtable != idtable:
		pass
	else:
		self.queue_free()
		EVENTS.delete_all_media.emit(idtable)
