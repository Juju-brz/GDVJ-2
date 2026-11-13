extends Node2D

@export var sub_viewport: SubViewport
@export var texRect: TextureRect
@export var colorRect : ColorRect
@export var BPM_Line_Edit : LineEdit

@export var file_dialog_texture : FileDialog

var id: int
signal color(BGColor : Color)
var switch = true

func _ready() -> void:
	var tex: ViewportTexture = $SubViewport.get_texture()
	EVENTS.code_pushed.connect(_on_code_pushed)
	if switch == true:
		texRect.texture = tex
	bpm_changed()

func _process(delta: float) -> void:
	EVENTS.color_changed.emit(colorRect.color)


func _on_code_pushed(code: String) -> void:
	colorRect.material.shader.code = code
	color.emit(colorRect.color)

func bpm_changed():
	GLOBAL.BPM = BPM_Line_Edit.text
	var bpmfloat = GLOBAL.BPM 
	var mat := colorRect.material as ShaderMaterial
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
	print(texture)
	print(texRect.texture)
