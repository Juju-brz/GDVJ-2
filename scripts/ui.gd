extends Control

#@export var color_palette : Control
@export var color_palette : Window
@export var Code_line : Window
@export var BPM_Line_Edit : LineEdit
#func _on_check_color_palette_button_down() -> void:
	#color_palette.hide()



func _on_check_color_palette_toggled(toggled_on: bool) -> void:
	color_palette.visible = toggled_on


func _on_check_code_toggled(toggled_on: bool) -> void:
	Code_line.visible = toggled_on



func _on_bpm_text_text_changed() -> void:
	pass
	#print("BPM change")


func _on_bpm_text_text_set() -> void:
	print("BPM is set")


func _on_bpm_line_edit_text_submitted(new_text: String) -> void:
	print("BPM submitted")
	GLOBAL.BPM = BPM_Line_Edit.text
	print("BPM value", GLOBAL.BPM)
	pass # Replace with function body.
