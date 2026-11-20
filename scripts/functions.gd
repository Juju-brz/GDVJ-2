extends Control

#@export var codeEdit : CodeEdit 
@export var file_dialog_save : FileDialog
var base := OS.get_executable_path().get_base_dir().path_join("contents")
var funcdir :=OS.get_executable_path().get_base_dir().path_join("contents/functions")

const FunctionTab = preload("res://UI/code_edit_func.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	search_functions()


### LOAD ###

func search_functions():
	for f in DirAccess.get_files_at(funcdir):
		var b = FunctionTab.instantiate()
		add_child(b)
		b.name = f.get_basename() 
		print(f)
		var path := funcdir.path_join(f)
		var file := FileAccess.open(path, FileAccess.READ)
		var content_to_string =file.get_as_text()
		
		## APPLY TO CODE TEXT
		if file == null:
			#pass
			continue
		else:
			b.text = content_to_string
			#var build = SHADERBUILDER.make_shader(b.text)
			#print(build)
			#print(b.text)
		
		#EVENTS.send_function.emit(content_to_string)
	print("funcdir", funcdir)


#func load_from_file(fileDir):
	#var file = FileAccess.open(fileDir, FileAccess.READ)
	#var content = file.get_as_text()
	#return content

### SAVE ###

func _on_button_save_pressed() -> void:
	file_dialog_save.show()

#func _on_file_selected(path: String) -> void:
	#var f := FileAccess.open(path, FileAccess.WRITE)
	#if f == null:
		#return
	#f.store_string(codeEdit.text)
	#print("save in : ", path)
