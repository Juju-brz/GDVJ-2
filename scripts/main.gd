extends Control

#signal user_code_emitted(user_code)

@onready var Code = $ColorRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#pass
	GLOBAL.code_pushed.connect(_on_code_pushed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_code_pushed(code: String) -> void:
	print("signal reçu : ", code)
	#Code.shader = GLOBAL.ShaderFrag
	Code.material.shader.code = code
	# exemple pour appliquer le shader :
	# material.shader.code = code
