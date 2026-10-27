extends Control

#@export var color_palette : Control
@export var color_palette : Window
@export var code_line : Window
@export var function : Window
@export var test : VBoxContainer

var selected_media = false

func _ready():
	GLOBAL.seleted_changed.connect(_receive_signal)
	
func _on_check_color_palette_toggled(toggled_on: bool) -> void:
	color_palette.visible = toggled_on


func _on_check_code_toggled(toggled_on: bool) -> void:
	code_line.visible = toggled_on


func _on_check_function_toggled(toggled_on: bool) -> void:
	function.visible = toggled_on

func _receive_signal(selected : bool):
	

	if selected:
		print("receive signal is selected")
		test.show()
		selected_media == true
	else:
	#BUG BECAUSE WHEN YOU CLICK NOt ON ZONE NO MEDIA RECIEVE SIGNAL WITHOUT EMIT
	#BECAUSE selected == false
		print("receive signal is not selected")
		test.hide()
