extends Control



func _on_del_all_but_pressed() -> void:
	self.queue_free()
