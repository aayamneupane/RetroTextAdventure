extends PanelContainer

onready var room_name = $MarginContainer/Rows/Title/RoomNameLabel
onready var room_descripton = $MarginContainer/Rows/DescriptionLabel
onready var item_label = $MarginContainer/Rows/List/ItemLabel
onready var npc_label = $MarginContainer/Rows/List/NpcLabel
onready var exit_label = $MarginContainer/Rows/List/ExitLabel

func _ready() -> void:
	pass

func on_room_changed(p_new_room) -> void:
	room_name.text = p_new_room.room_name
	room_descripton.text = p_new_room.room_description
	
	var npc_string = p_new_room.get_npc_description()
	if npc_string == "":
		npc_label.hide()
	else:
		npc_label.bbcode_text = npc_string
		
	var item_string = p_new_room.get_item_description()
	if item_string == "":
		item_label.hide()
	else:
		item_label.bbcode_text = item_string
		
	exit_label.bbcode_text = p_new_room.get_exit_description()
	
func on_room_updated(p_current_room) -> void:
	on_room_changed(p_current_room)
