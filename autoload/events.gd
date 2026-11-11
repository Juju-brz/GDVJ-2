extends Node

### SIGNALS ###

signal code_pushed(code)
signal color_changed(bg_color: Color)
signal seleted_changed(is_dragging: bool)
signal loading_screen(time:float)

#MEDIA
signal button_compo(id :int)
signal add_button_compo_icon(id : int , icon: Texture2D)
signal hide_media(id : int)
signal lock_media(id : int)
signal add_id_media(id : int)
signal delete_icon
signal delete_media(id : int)
signal delete_all_media()
