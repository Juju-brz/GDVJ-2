extends Control

#@export var color_palette : Control
@export var color_palette : Window
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_check_button_2_button_down() -> void:
	color_palette.hide()


func _on_check_button_2_button_up() -> void:
	color_palette.show()
