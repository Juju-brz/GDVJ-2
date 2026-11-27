extends Node2D

@export var texRect: TextureRect
@export var BPM_Line_Edit : LineEdit
@export var file_dialog_texture : FileDialog


func _ready() -> void:
	#var tex: ViewportTexture = $SubViewport.get_texture()
	EVENTS.code_pushed.connect(_on_code_pushed)
	file_dialog_texture.always_on_top = true
	#shader = SHADERBUILDER.make_shader(GLOBAL.ShaderFrag)
	#colorRect.material.shader = shader
	apply_shader()
	bpm_changed()
	


func _on_code_pushed(code: String) -> void:
	texRect.material.shader.code = code
	apply_shader()

func bpm_changed():
	GLOBAL.BPM = BPM_Line_Edit.text
	var bpmfloat = GLOBAL.BPM 
	var mat := texRect.material as ShaderMaterial
	mat.set_shader_parameter("BPM", bpmfloat)
	print("BPM submitted")
	print("BPM value", GLOBAL.BPM)

func _on_bpm_line_edit_text_submitted(new_text: String) -> void:
	bpm_changed()

func _on_import_tex_but_pressed() -> void:
	file_dialog_texture.show()

func _on_file_dialog_texture_file_selected(path: String) -> void:
	#switch = false
	var texture = Image.load_from_file(path)
	#texRect.texture = texture
	texRect.texture = ImageTexture.create_from_image(texture)
	#print(texture)
	#print(texRect.texture)


func apply_shader():
	var shader: Shader = SHADERBUILDER.make_shader(GLOBAL.ShaderFrag)
	var mat := ShaderMaterial.new()
	mat.shader = shader               
	texRect.material = mat          
