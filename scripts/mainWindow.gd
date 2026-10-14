extends Node2D

@export var sub_viewport: SubViewport
@export var texRect: TextureRect
@export var Code : ColorRect
signal color(BGColor : Color)
var switch = true

var test = 200

func _ready() -> void:
	var tex: ViewportTexture = $SubViewport.get_texture()
	GLOBAL.code_pushed.connect(_on_code_pushed)
	#result.texture = tex
	if switch == true:
		texRect.texture = tex
		
	#file_dialog.file_selected.connect(on_file_selected)
	test_func()

func _process(delta: float) -> void:
	GLOBAL.color_changed.emit(Code.color)


func _on_code_pushed(code: String) -> void:
	Code.material.shader.code = code
	color.emit(Code.color)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("sound_BPM"):
		test_func()

func test_func():
	var bpmfloat = GLOBAL.BPM 
	var mat := Code.material as ShaderMaterial
	mat.set_shader_parameter("BPM", bpmfloat)
	print("proute")


func _on_bpm_line_edit_text_submitted(new_text: String) -> void:
	test_func()
