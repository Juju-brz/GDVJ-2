extends Control

var numberanim : Array
var animplay = false
var looptime : int
var playlist = false

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
		print("anim import ","id", numberanim)
	

func delete_id_array(id):
	numberanim.erase(id)
	print("anim delette ","id", numberanim)

var stop = false
func _on_clip_play_but_pressed() -> void:
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
