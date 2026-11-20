extends CodeEdit

@export var SaveFileDialog : FileDialog
@export var codeEdit : CodeEdit 
var code : String

func _ready() -> void:
	higlighting()

func _on_save_but_pressed() -> void:
	SaveFileDialog.show()


func _on_text_changed() -> void:
	code = self.text


func _on_compile_but_pressed() -> void:
	SHADERBUILDER.libs_text = SHADERBUILDER.load_libs()


func _on_file_dialog_file_selected(path: String) -> void:
	var f := FileAccess.open(path, FileAccess.WRITE)
	if f == null:
		print("save null")
		return
	f.store_string(code)
	print("save in : ", path)


func higlighting():
	var h := CodeHighlighter.new()
	
	h.number_color = Color("4f82f3")
	h.symbol_color = Color("359f5c")
	h.function_color = Color("fdcb00")
	h.member_variable_color = Color("f5a8c0")
	h.add_color_region("//", "", Color("6a646366"), true)
	

	for t in ["float", "int", "bool", "vec2", "vec3", "vec4", "mat2", "mat3",
			"mat4", "sampler2D", "ivec2", "uvec2"]:
		h.add_keyword_color(t, Color("ff7c6b"))
		
	syntax_highlighter = h
