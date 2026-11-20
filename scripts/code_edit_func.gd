extends CodeEdit

@export var SaveFileDialog : FileDialog
@export var codeEdit : CodeEdit 
var code : String

func _on_save_but_pressed() -> void:
	SaveFileDialog.show()


func _on_text_changed() -> void:
	code = self.text


func _on_compile_but_pressed() -> void:
	#pass # Replace with function body.
	SHADERBUILDER.libs_text = SHADERBUILDER.load_libs()


func _on_file_dialog_file_selected(path: String) -> void:
	var f := FileAccess.open(path, FileAccess.WRITE)
	if f == null:
		print("save null")
		return
	f.store_string(code)
	print("save in : ", path)
