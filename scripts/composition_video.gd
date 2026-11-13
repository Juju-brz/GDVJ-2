extends Control

var numberanim : Array
var animOrder : Array
var animplay = false
var looptime : int
var playlist = false
var stop = false

func _on_del_all_but_pressed() -> void:
	self.queue_free()

func _ready() -> void:
	EVENTS.add_id_media.connect(add_id_array)
	EVENTS.delete_media.connect(delete_id_array)
	EVENTS.anim_finish.connect(animation_finish)

func add_id_array(id):
	var d = id
	if d in numberanim:
		pass 
	else:
		numberanim.append(id)
		numberanim = quicksort(numberanim)
		print("anim import ","id", numberanim)
		#animOrder = quicksort(numberanim)
		#print("Order anim import ","id", animOrder)

func delete_id_array(id):
	numberanim.erase(id)
	print("anim delette ","id", numberanim)


func _on_clip_play_but_pressed() -> void:
	stop = false
	play_clip()

func _on_check_button_toggled(toggled_on: bool) -> void:
	play_clip()
	if toggled_on == false:
		stop = true

func play_clip():
	#playlist = true
	#var stop = false
	if numberanim.is_empty():
		pass
	else:
		while stop == false:
			EVENTS.anim_stop.emit()
			for i in numberanim:
				print(i)
				EVENTS.anim_play.emit(i)
				await EVENTS.anim_finish
			animplay = false

func animation_finish():
	animplay = true
	print(" animplay = true")

func _on_line_edit_text_submitted(new_text: String) -> void:
	#looptime = new_text.to_int()
	#EVENTS.loop_time.emit(looptime)
	GLOBAL.loop = new_text.to_int()


# REORGANIZE ARRAY ANIM #
func quicksort(list: Array):
	if list.size() <= 1: 
		return list  
	  
	var pivot = list[0] #WTF !!!??
	  
	var little = []  
	var big = []
	print("pivot", pivot)
	
	for number in list:  
		if number < pivot:  
			little.append(number)  
			#print("little", little)
		if number > pivot:  
			big.append(number)  
			#print("big",big)

	return quicksort(little) + [pivot] + quicksort(big)


func _on_button_pressed() -> void:
	stop = true
