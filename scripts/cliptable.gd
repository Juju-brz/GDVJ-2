extends HBoxContainer


const ButtonComp = preload("res://UI/button_compo_video.tscn")


func _on_add_clip_but_pressed() -> void:
	#pass # Replace with function body.
	var b = ButtonComp.instantiate()
	add_child(b)
	print(ButtonComp)
