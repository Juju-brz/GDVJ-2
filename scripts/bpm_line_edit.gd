extends LineEdit


var _regex := RegEx.new()

func _ready() -> void:
	_regex.compile("[^0-9]")
	#text_changed.connect(_on_text_changed)


func _gui_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if (event.ctrl_pressed or event.meta_pressed) and not event.alt_pressed:
			return
		var c: int = event.unicode
		if c == 0:
			return
		if c < 48 or c > 57:
			accept_event()
