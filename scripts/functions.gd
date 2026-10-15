extends Control

@export var codeEdit : CodeEdit 
@export var FileDialogSave : FileDialog

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	load_from_file("res://functions/test.juju")
	codeEdit.text = load_from_file("res://functions/test.juju")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func load_from_file(fileDir):
	var file = FileAccess.open(fileDir, FileAccess.READ)
	var content = file.get_as_text()
	print(file)
	print(content)
	return content


func _on_button_save_pressed() -> void:
	FileDialogSave.show()


func _on_file_dialog_save_confirmed() -> void:
	print("proute")
	pass # Replace with function body.
