extends Sprite2D


# Called when the node enters the scene tree for the first time.
@export var texRect :TextureRect
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	var mat := CanvasItemMaterial.new()
	mat.blend_mode = CanvasItemMaterial.BLEND_MODE_MUL
	material = mat

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
