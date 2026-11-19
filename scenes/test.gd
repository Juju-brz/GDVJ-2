extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	apply_shader()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func apply_shader():
	var shader: Shader = SHADERBUILDER.make_shader(GLOBAL.ShaderFrag)

	var mat := ShaderMaterial.new()   # le matériau
	mat.shader = shader               # le shader va DANS le matériau
	self.material = mat          

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("test"):
		apply_shader()
