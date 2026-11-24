extends Node

### SIGNALS ###

signal code_pushed(code : String)
#signal color_changed(bg_color: Color)
signal seleted_changed(is_dragging: bool)
signal loading_screen(time:float)

## CODE ##
#signal send_function(function : String)

### MEDIA ####
signal button_compo(id :int)
signal add_button_compo_icon(id : int , icon: Texture2D)
signal hide_media(id : int)
signal lock_media(id : int)
signal add_id_media(id : int, idTable : int)
signal delete_icon
signal delete_media(id : int)
signal delete_all_media()
signal replace_ex_media(id: int)
signal compotable(idtable: String)
# Playlist #
signal anim_stop(idtable : int)
signal anim_play(id : int, idTable : int)
signal anim_finish(idTable : int)
signal loop_time(looptime : int, idTable : int)
signal exit_playlist(idTable : int)
