extends AnimatedSprite2D


var is_dragging := false
var drag_offset := Vector2.ZERO

var is_selected := false
@onready var sprite
var zoom_mode = false
var lock = false
#@export var emetteur: Node
var hidebool : bool = false

#@export var texRect :TextureRect

var id  = null

func _init():
	
	#EVENTS.add_button_compo_icon.connect(assign_id)
	EVENTS.add_id_media.connect(assign_id)

func _ready():
	EVENTS.button_compo.connect(_on_button_compo_video_pressed)
	EVENTS.hide_media.connect(hide_media)
	EVENTS.lock_media.connect(lock_media)
	
	EVENTS.add_button_compo_icon.connect(assign_id)
	EVENTS.delete_media.connect(delete_image)
	EVENTS.delete_all_media.connect(delette_all)
	EVENTS.anim_stop.connect(stop_anim)
	EVENTS.anim_play.connect(play_anim)
	#EVENTS.test.connect(assign_id)
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
	COLOR = vec4(mix(vec3(1.0), c.rgb, c.a), 1.0);
}
"""
	var mat := ShaderMaterial.new()
	mat.shader = shader
	material = mat
	### MULTIPLY BLEND MODE ###

func _on_button_compo_video_pressed():
	print("choucroute farchis")

func _input(event):
	if Input.is_action_just_pressed("media_change_mode"):
		if zoom_mode == true:
			zoom_mode = false
		else:
			zoom_mode = true
	
	
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if get_sprite_rect().has_point(to_local(event.position)):
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
				scale = scale.clamp(Vector2(0.1, 0.1), Vector2(10, 10)) 
		
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
					scale = scale.clamp(Vector2(0.1, 0.1), Vector2(10, 10))  #Limit Size
			if Input.is_action_just_pressed("media_front"):
				bring_to_front()
			if Input.is_action_just_pressed("media_back"):
				send_to_back()
			
			if Input.is_action_just_pressed("media_delete"):
				delete_image(id)

func delete_image(buttonid):
	if buttonid != id:
		pass
	else:
		queue_free()
		EVENTS.delete_icon.emit(buttonid)

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

func get_sprite_rect() -> Rect2:
	if sprite_frames == null:
		return Rect2()
	var tex := sprite_frames.get_frame_texture(animation, frame)
	#tex.Vector2(200.0, 200.0)
	if tex == null:
		return Rect2()
	var size := tex.get_size()
	var top_left := -size * 0.5 if centered else Vector2.ZERO
	return Rect2(top_left + offset, size)

func hide_media(buttonid):
	if buttonid != id:
		pass
	else:
		if hidebool == false:
			self.visible = false
			hidebool = true
		else:
			self.visible = true
			hidebool = false

func lock_media(buttonid):
	if buttonid != id:
		pass
	else:
		if lock == true:
			lock = false
		else:
			lock = true

func assign_id(buttonid):
	if id != null:
		pass
	else:
		id = buttonid
		print("id image apply")
		print("id image", id)

func delette_all():
	queue_free()


func stop_anim():
	self.stop()
	self.visible = false

var playlist = false

func play_anim(idArray):
	if idArray != id:
		pass
	else:
		playlist = true
		self.visible = true
		#self.fra
		self.play()
		#EVENTS.anim_finish.emit()


#func _on_animation_finished() -> void:
	#if playlist == true:
		#
		#EVENTS.anim_finish.emit()


func _on_animation_looped() -> void:
	if playlist == true:
		EVENTS.anim_finish.emit()
		print("loop")
		stop_anim()
