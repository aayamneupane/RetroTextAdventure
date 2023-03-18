extends Resource

class_name Exit

var room_1 = null

var room_2 = null
var is_locked: bool = false

func _ready() -> void:
	pass
	
	
#func is_other_room_locked(p_current_room) -> bool:
#
#	if p_current_room == room_1:
#		return is_room_2_locked
#	elif p_current_room == room_2:
#		return is_room_1_locked
#	else:
#		printerr("The room is not connected to this exit ")
#		return true
	


func get_other_room(p_current_room):
	if p_current_room == room_1:
		return room_2
	elif p_current_room == room_2:
		return room_1
	else:
		 printerr(Types.wrap_item_text("The room is not connected to the exit "))
		
		

