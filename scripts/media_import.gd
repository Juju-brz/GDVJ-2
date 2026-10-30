extends Node2D



### IMPORT MEDIA ###
var instances: Array = []  #All media imported
const TARGET_SIZE := 200.0 
@export var file_dialog_image : FileDialog
@export var file_dialog_video : FileDialog
const MediaScene = preload("res://scenes/media.tscn")
const AnimScene = preload("res://scenes/Animation.tscn")
#@export var canvas : CanvasLayer
@export var color_rect : ColorRect

func _ready() -> void:
	file_dialog_image.file_selected.connect(on_file_selected)
	file_dialog_video.dir_selected.connect(_on_dir_selected)


func open_file_dialog_image():
	file_dialog_image.show()


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
	
	#ResourceLoader.load_threaded_request(new_instance)
	instances.append(new_instance)

func _on_dir_selected(dir : String): 
	var new_instance = AnimScene.instantiate()
	add_child(new_instance)
	var files := Array(DirAccess.get_files_at(dir)).filter(
		func(f): return f.get_extension().to_lower() in ["png", "jpg", "jpeg", "webp"]
	)
	files.sort_custom(func(a, b): return a.naturalnocasecmp_to(b) < 0)

	var frames := SpriteFrames.new()
	frames.set_animation_speed("default", 24)
	for f in files:
		var img := Image.load_from_file(dir.path_join(f))
		if img != null:
			frames.add_frame("default", ImageTexture.create_from_image(img))

	new_instance.sprite_frames = frames
	new_instance.play("default")
	new_instance.position = Vector2(640, 360)
	print("import animation",new_instance)

func _on_button_image_pressed() -> void:
	open_file_dialog_image()


func _on_button_video_pressed() -> void:
	file_dialog_video.show()
