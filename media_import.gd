extends Node2D

### BLEND MODE ###
# Called when the node enters the scene tree for the first time.
#@export var texRect :TextureRect
## Called when the node enters the scene tree for the first time.
#
#func _ready() -> void:
	#var mat := CanvasItemMaterial.new()
	#mat.blend_mode = CanvasItemMaterial.BLEND_MODE_MUL
	#material = mat
#


### IMPORT MEDIA
var instances: Array = []  #All media imported
const TARGET_SIZE := 200.0 
@export var file_dialog : FileDialog
const MediaScene = preload("res://scenes/media.tscn")
@export var canvas : CanvasLayer
@export var color_rect : ColorRect

func _ready() -> void:
	file_dialog.file_selected.connect(on_file_selected)


func open_file_dialog():
	file_dialog.show()

func _on_button_pressed() -> void:
	open_file_dialog()

func on_file_selected(path: String) -> void:
	var image = Image.load_from_file(path)
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
		new_instance.queue_free()
		return
	
	if new_instance is Node2D:
		var screen_size = get_viewport_rect().size
		new_instance.position = screen_size * 0.5
	
	instances.append(new_instance)
	#canvas.add_child(new_instance)
	#print("add media ", new_instance)
	#print("position", new_instance.position)
	#print(new_instance.is_inside_tree()) 
	#print(new_instance.get_parent().get_path())  
	#print(new_instance.visible, " ", new_instance.get_global_position())
	#new_instance.color_rect = color_rect
