tool
extends PanelContainer

class_name GameRoom

export (String) var room_name := "Room Name" setget set_room_name
export (String, MULTILINE) var room_description := "This is a room description" setget set_room_description

var exits : Dictionary = {
}

var items: Array = []
var npcs: Array = []

func set_room_name(p_room_name : String) :
	$MarginContainer/Rows/RoomName.text = p_room_name
	room_name = p_room_name


func set_room_description(p_room_description : String ):
	$MarginContainer/Rows/RoomDescription.text = p_room_description
	room_description = p_room_description


func add_item(p_item: Item):
	items.append(p_item)
	
func add_npc(p_npc: NPC):
	npcs.append(p_npc)
	
func remove_item(p_item: Item):
	items.erase(p_item)
	
	
func get_full_description() -> String:
	
	var full_description = PoolStringArray([get_room_description()])
	var item_description = get_item_description()
	var npc_description = get_npc_description()
	if npc_description != "":
		full_description.append(get_npc_description())
	if item_description != "":
		full_description.append(get_item_description())
	full_description.append(get_exit_description())
	var full_description_string = full_description.join("\n")
	return full_description_string
	
	
func get_exit_description() -> String:
	
	return "Exits: " + Types.wrap_location_text(PoolStringArray(exits.keys()).join(" "))
	
func get_room_description() -> String:
	
	return "You are now in " + Types.wrap_location_text(room_name) + ". This is " + room_description
	
	
func get_item_description() -> String:
	
	if items.size() == 0:
		return ""
	var item_string = ""
	for item in items:
		item_string += item.item_name + ""
	return "Items: " + Types.wrap_item_text(item_string)
	
	
func get_npc_description() -> String:
	
	if npcs.size() == 0:
		return ""
	var npc_string = ""
	for npc in npcs:
		npc_string += npc.npc_name + ""
	return "NPCs: " + Types.wrap_npc_text(npc_string)
	
	
func connect_exit_unlocked(direction: String, room: GameRoom, p_room_2_override_name = "null"):
	return _connect_exit(direction, room, false, p_room_2_override_name)
	
func connect_exit_locked(p_direction: String, room: GameRoom, p_room_2_override_name= "null"):
	return _connect_exit(p_direction, room, true, p_room_2_override_name)

	
func _connect_exit(p_direction: String, p_room: GameRoom, is_locked: bool = false, p_room_2_override_name = "null"):
	
	var exit = Exit.new()
	exit.room_1 = self
	exit.room_2 = p_room
	exit.is_locked = is_locked
	exits[p_direction] = exit

	if p_room_2_override_name != "null":
#		print ("Entered this condition")
		p_room.exits[p_room_2_override_name] = exit
	else:
		match p_direction:
			"west":
				p_room.exits["east"] = exit
			"east":
				p_room.exits["west"] = exit
			"north":
				p_room.exits["south"] = exit
			"south":
				p_room.exits["north"] = exit
				
			"path":
				p_room.exits["path"] = exit
				
			"inside":
				p_room.exits["outside"] = exit
				
			"outside":
				p_room.exits["inside"] = exit
			_:
				printerr("Invalid Direction")
				
	return exit
