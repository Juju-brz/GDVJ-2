extends Sprite2D  # ou Area2D

# Variables pour le déplacement
var is_dragging := false
var drag_offset := Vector2.ZERO

# Variable pour la sélection
var is_selected := false
@onready var file_dialog = $"../ControlUI/FileDialog"
@onready var sprite = $Sprite2D
var zoom_mode = false
var lock = false

func _ready():
	set_process_input(true)

func _input(event):
	if Input.is_action_just_pressed("change_mode"):
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
				is_selected = false  # Désélectionne si on clique ailleurs
		else:
			is_dragging = false

	# Zoom avec la molette UNIQUEMENT si l'objet est sélectionné
	if is_selected:
		if Input.is_action_just_pressed("lock"):
			if lock == true:
				lock = false
				print(lock)
			else:
				lock = true
				print(lock)
		
		if lock == true:
			pass
		else:
			if Input.is_action_pressed("zoom_in"):
				scale += Vector2(0.05, 0.05)  
			elif Input.is_action_pressed("zoom_out"):
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
			if Input.is_action_just_pressed("front"):
				bring_to_front()
			if Input.is_action_just_pressed("back"):
				send_to_back()
		
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
