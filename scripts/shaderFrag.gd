extends CodeEdit
class_name  ShaderCode

@onready var code = self
var shader_path = "res://shaders/mainShader.gdshader"


func _ready():
	var execute = $Execute
	execute.pressed.connect(_on_execute_pressed)
	
	code.text = GLOBAL.ShaderFrag


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("execute_shader"):
		_on_execute_pressed()

#signal CodePush(code)

func _on_execute_pressed() -> void:
	var user_code = self.text
	GLOBAL.ShaderFrag = user_code
	GLOBAL.code_pushed.emit(user_code)
	#CodePush.emit(user_code)
	print("signal emit : code Shader")
	
