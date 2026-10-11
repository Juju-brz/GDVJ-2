extends Sprite2D

var is_dragging := false
var drag_offset := Vector2.ZERO

var is_selected := false
@onready var sprite
var zoom_mode = false
var lock = false
@export var emetteur: Node


#@export var texRect :TextureRect
## Called when the node enters the scene tree for the first time.
func _ready():
	sprite = self
	set_process_input(true)
	#GLOBAL.color_changed.connect(_on_color_changed)
	
	### MULTIPLY BLEND MODE ###
	var shader := Shader.new()
	shader.code = """
shader_type canvas_item;
render_mode blend_mul;

void fragment() {
	vec4 c = texture(TEXTURE, UV);
	// transparent -> blanc (neutre), opaque -> sa vraie couleur
	COLOR = vec4(mix(vec3(1.0), c.rgb, c.a), 1.0);
}
"""
	var mat := ShaderMaterial.new()
	mat.shader = shader
	material = mat
	### MULTIPLY BLEND MODE ###



func _input(event):
	if Input.is_action_just_pressed("media_change_mode"):
		if zoom_mode == true:
			zoom_mode = false
		else:
			zoom_mode = true
	
	
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if get_rect().has_point(to_local(event.position)):
				is_selected = true
				is_dragging = true
				drag_offset = global_position - get_global_mouse_position()
			else:
				is_selected = false 
		else:
			is_dragging = false
		
	if is_selected:
		if Input.is_action_just_pressed("media_lock"):
			if lock == true:
				lock = false
				print(lock)
			else:
				lock = true
				print(lock)
		
		if lock == true:
			pass
		else:
			if Input.is_action_pressed("media_zoom_in"):
				scale += Vector2(0.05, 0.05)  
			elif Input.is_action_pressed("media_zoom_out"):
				scale -= Vector2(0.05, 0.05)
				scale = scale.clamp(Vector2(0.1, 0.1), Vector2(10, 10))  # Limite la taille
		
			if zoom_mode == false:
				if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_WHEEL_UP:
					rotation += 0.05
				elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
					rotation -= 0.05
			if zoom_mode == true:
				if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_WHEEL_UP:
					scale += Vector2(0.05, 0.05)  
				elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
					scale -= Vector2(0.05, 0.05)
					scale = scale.clamp(Vector2(0.1, 0.1), Vector2(10, 10))  # Limite la taille
			if Input.is_action_just_pressed("media_front"):
				bring_to_front()
			if Input.is_action_just_pressed("media_back"):
				send_to_back()
			
			if Input.is_action_just_pressed("media_delete"):
				delete_image()

func delete_image():
	queue_free()

func _process(delta):
	if is_dragging:
		if lock == true:
			pass
		else:
			global_position = get_global_mouse_position() + drag_offset


func bring_to_front() -> void:
	get_parent().move_child(self, -1)

func send_to_back() -> void:
	get_parent().move_child(self, +1)  
	

func _on_color_changed(bg_color: Color) -> void:
	sprite.material.set_shader_parameter("blend_color", bg_color)
