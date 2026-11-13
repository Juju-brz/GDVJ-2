extends HBoxContainer


const ButtonComp = preload("res://UI/button_compo_video.tscn")
var buttonArray : Array

func _on_add_clip_but_pressed() -> void:
	#pass # Replace with function body.
	var b = ButtonComp.instantiate()
	add_child(b)
	print(ButtonComp)
	buttonArray.append(b)
	print(buttonArray)


func _on_del_clip_but_pressed() -> void:
	buttonArray.pop_back()
