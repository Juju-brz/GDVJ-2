extends Control

#signal user_code_emitted(user_code)

@onready var Code = $ColorRect
@onready var file_dialog
const MediaScene = preload("res://scenes/media.tscn")

#MEDIA
var instances: Array = []  #All media imported
const TARGET_SIZE := 200.0 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#pass
	file_dialog = $FileDialog
	file_dialog.file_selected.connect(on_file_selected)
	
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

func open_file_dialog():
	file_dialog.show()


func _on_button_pressed() -> void:
	open_file_dialog()


func on_file_selected(path: String) -> void:
	var image = Image.load_from_file(path)
	if not image:
		print("Erreur : Impossible de charger l'image à partir de ", path)
		return

	var texture = ImageTexture.create_from_image(image)

	var new_instance = MediaScene.instantiate()
	add_child(new_instance)

	var sprite_node = null
	if new_instance is Sprite2D:
		sprite_node = new_instance
	elif new_instance.has_node("Sprite2D"):
		sprite_node = new_instance.get_node("Sprite2D")

	if sprite_node:
		sprite_node.texture = texture
		sprite_node.centered = true

		var img_size = image.get_size()
		var max_dimension = max(img_size.x , img_size.y)
		var scale_factor = TARGET_SIZE / max_dimension
		new_instance.scale = Vector2(scale_factor, scale_factor)
	else:
		print("Erreur : Aucun Sprite2D trouvé dans la scène importée.")
		new_instance.queue_free()
		return

	if new_instance is Node2D:
		var screen_size = get_viewport_rect().size
		new_instance.position = screen_size * 0.5

	instances.append(new_instance)
