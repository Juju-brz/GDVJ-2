extends Node2D

@export var sub_viewport: SubViewport
@export var texRect: TextureRect
@export var Code : ColorRect
signal color(BGColor : Color)
var switch = true

func _ready() -> void:
	var tex: ViewportTexture = $SubViewport.get_texture()
	GLOBAL.code_pushed.connect(_on_code_pushed)
	#result.texture = tex
	if switch == true:
		texRect.texture = tex
		
	#file_dialog.file_selected.connect(on_file_selected)

func _process(delta: float) -> void:
	GLOBAL.color_changed.emit(Code.color)


func _on_code_pushed(code: String) -> void:
	Code.material.shader.code = code
	color.emit(Code.color)
