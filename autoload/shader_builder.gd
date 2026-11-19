# shader_builder.gd (Autoload)
extends Node

var libs_text := ""

func _ready() -> void:
	libs_text = load_libs()

func load_libs() -> String:
	var dir := OS.get_executable_path().get_base_dir().path_join("contents/functions")
	var out := ""
	var files := Array(DirAccess.get_files_at(dir)).filter(
		func(f): return f.get_extension() == "gdshaderinc")
	files.sort()
	for f in files:
		out += FileAccess.get_file_as_string(dir.path_join(f)) + "\n"
	return out

func make_shader(main_code: String) -> Shader:
	var s := Shader.new()
	s.code = main_code.insert(main_code.find(";") + 1, "\n" + libs_text)
	return s
