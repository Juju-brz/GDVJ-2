extends Control

@export var codeEdit : CodeEdit 
@export var file_dialog_save : FileDialog
var base := OS.get_executable_path().get_base_dir().path_join("content")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_from_file("res://contents/functions/functions.gdshaderinc")
	codeEdit.text = load_from_file("res://contents/functions/functions.gdshaderinc")
	file_dialog_save.file_selected.connect(_on_file_selected)
	codeEdit.duplicate()


### LOAD ###

func load_from_file(fileDir):
	var file = FileAccess.open(fileDir, FileAccess.READ)
	var content = file.get_as_text()
	return content


### SAVE ###

func _on_button_save_pressed() -> void:
	file_dialog_save.show()


func _on_file_selected(path: String) -> void:
	var f := FileAccess.open(path, FileAccess.WRITE)
	if f == null:
		return
	f.store_string(codeEdit.text)
	print("save in : ", path)
