extends Control

#@export var color_palette : Control
@export var color_palette : Window
@export var code_line : Window
@export var function : Window

func _on_check_color_palette_toggled(toggled_on: bool) -> void:
	color_palette.visible = toggled_on


func _on_check_code_toggled(toggled_on: bool) -> void:
	code_line.visible = toggled_on


func _on_check_function_toggled(toggled_on: bool) -> void:
	function.visible = toggled_on
