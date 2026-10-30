extends Node2D

@export var sub_viewport: SubViewport
@export var texRect: TextureRect
@export var colorRect : ColorRect

var id: int
signal color(BGColor : Color)
var switch = true
@export var BPM_Line_Edit : LineEdit

func _ready() -> void:
	var tex: ViewportTexture = $SubViewport.get_texture()
	GLOBAL.code_pushed.connect(_on_code_pushed)
	if switch == true:
		texRect.texture = tex
	bpm_changed()
	#Code.text.insert(1, "proute")

func _process(delta: float) -> void:
	GLOBAL.color_changed.emit(colorRect.color)


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
