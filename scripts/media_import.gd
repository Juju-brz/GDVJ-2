extends Node2D



### IMPORT MEDIA ###
var instances: Array = []  #All media imported
const TARGET_SIZE := 200.0 
@export var file_dialog_image : FileDialog
@export var file_dialog_video : FileDialog
@export var loading_screen : Control
const MediaScene = preload("res://scenes/media.tscn")
const AnimScene = preload("res://scenes/Animation.tscn")
#@export var canvas : CanvasLayer
@export var color_rect : ColorRect
@export var ButtonCompoVideo : Button

func _ready() -> void:
	file_dialog_image.file_selected.connect(on_file_selected)
	file_dialog_video.dir_selected.connect(on_dir_selected)
	EVENTS.button_compo.connect(_on_button_compo_video_pressed)

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
	#new_instance.next_id +=1
	print("id", new_instance.next_id)

func on_dir_selected(dir : String): 
	var files: Array = Array(DirAccess.get_files_at(dir)).filter(
		func(f): return f.get_extension().to_lower() in ["png", "jpg", "jpeg", "webp"]
	)
	files.sort_custom(func(a, b): return a.naturalnocasecmp_to(b) < 0)
	files = files.map(func(f): return dir.path_join(f))

	var textures: Array = []
	textures.resize(files.size())
	
	### DONT FREEZE SCREEN
	var task_id := WorkerThreadPool.add_group_task(
		func(i):
			var img := Image.load_from_file(files[i])
			if img != null and not img.is_empty():
				textures[i] = ImageTexture.create_from_image(img),
		files.size()
	)
	while not WorkerThreadPool.is_group_task_completed(task_id):
		await get_tree().process_frame
	WorkerThreadPool.wait_for_group_task_completion(task_id)

	# Sur le thread principal : seulement l'assemblage, quasi instantané
	var frames := SpriteFrames.new()
	frames.set_animation_speed("default", 24)
	for tex in textures:
		if tex != null:
			frames.add_frame("default", tex)

	var new_instance = AnimScene.instantiate()
	add_child(new_instance)
	new_instance.sprite_frames = frames
	new_instance.position = Vector2(640, 360)
	new_instance.play("default")

func _on_button_image_pressed() -> void:
	open_file_dialog_image()


func _on_button_video_pressed() -> void:
	file_dialog_video.show()


func _on_button_compo_video_pressed(id) -> void:
	file_dialog_video.show()
	#ButtonCompoVideo.icon = load("res://media/jujuLogo.png")
