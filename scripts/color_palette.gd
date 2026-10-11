extends Control
@export var color_picker : ColorPicker


func _on_button_pressed() -> void:
	var c: Color = color_picker.color
	var output: String = "vec3(%.2f, %.2f, %.2f);" % [c.r, c.g, c.b]
	DisplayServer.clipboard_set(output)
	print(output)
