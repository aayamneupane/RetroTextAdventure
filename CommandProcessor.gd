extends Node

var current_room: GameRoom = null

var player

signal room_changed

signal room_updated


func initialize(starting_room, p_player) -> String:
	self.player = p_player
	return change_room(starting_room)


func process_command(input: String) -> String:
	var words = input.split(" ")
	if words.size() == 0:
		print("Please Enter Input")
	var first_word = words[0].to_lower()
	var second_word = ""
	
	if words.size() > 1:
		second_word = words[1].to_lower()
	
	match first_word:
		
		"go":
			return go(second_word)
			
		"help":
			return help()
			
		"take":
			return take(second_word)
			
		"use":
			return use(second_word)
			
		"talk":
			return talk(second_word)
			
		"inventory":
			return display_inventory()
			
		"give":
			return give(second_word)
			
		"drop":
			return drop(second_word)
			
		_:
			return Types.wrap_system_text("You have typed an Invalid Command")
			
			
func display_inventory() -> String:
		return player.get_inventory_list()


func take(p_second_word: String) -> String:
	
	if (p_second_word == ""):
		return Types.wrap_system_text("Take What?")
		
	for item in current_room.items:
		if p_second_word.to_lower() == item.item_name.to_lower():
			player.pickup_item(item)
			current_room.remove_item(item)
			emit_signal("room_updated", current_room)
			return "You took the " + Types.wrap_item_text(item.item_name)
	return Types.wrap_system_text("The item you want is not in this room.")
	
	
func use(p_second_word: String) -> String:
	
	if (p_second_word == ""):
		return Types.wrap_system_text("Use What?")
		
	for item in player.inventory:
		if p_second_word.to_lower() == item.item_name.to_lower():
			match item.item_type:
				Types.ItemTypes.KEY:
					for exit in current_room.exits.values():
						if exit == item.use_value:
							print(exit)
							print(item.use_value)
							exit.is_locked = false
							return "You just used %s to unlock %s" %[item.item_name, exit.get_other_room(current_room).room_name] 
							player.drop_item(item)
					return "The item doesnot unlock this room"
				_:
					return "Error 404"
#			player.use_item(item)
#			return "You used the " + item.item_name
	return Types.wrap_system_text("The item you want is not in this room.")
	
	
func talk(p_second_word: String) -> String:
	
	if p_second_word == "":
		return Types.wrap_system_text("Talk to Who?")
		
	for npc in current_room.npcs:
		if npc.npc_name.to_lower() == p_second_word:
			var dialog = npc.post_quest_dialogue if npc.has_received_quest_item else npc.initial_dialogue
			return Types.wrap_npc_text(npc.npc_name) + ": " + Types.wrap_speech_text(dialog)
			
	return Types.wrap_system_text("That person does not exist in this room")
	
	
func give(p_second_word: String) -> String:
	if p_second_word == "":
		return Types.wrap_system_text("Give What?")
		
	var has_item := false
	for item in player.inventory:
		if p_second_word.to_lower() == item.item_name.to_lower():
			has_item = true
			
	if not has_item:
		return Types.wrap_system_text("You dont have that item")
		
	for npc in current_room.npcs:
		if npc.quest_item != null and p_second_word.to_lower() == npc.quest_item.item_name.to_lower():
			npc.has_received_quest_item = true
			if npc.quest_reward != null:
				var reward = npc.quest_reward
				if "is_locked" in reward:
					reward.is_locked = false
				else:
					printerr("Warning: You tried to have a quest reward type that is not implemented")
			player.drop_item(p_second_word)
			return "You gave the %s item to the %s" %[p_second_word, npc.npc_name]
	return "boom boom"
	
func drop(p_second_word: String) -> String:
	
	if p_second_word == "":
		return Types.wrap_system_text("Drop What?")
		
	for item in current_room.items:
		if p_second_word.to_lower() == item.item_name.to_lower():
			player.drop_item(item)
			current_room.add_item(item)
			emit_signal("room_updated", current_room)
			return "You took the " + item.item_name
	return Types.wrap_system_text("You do not have the item.")


func go(	p_second_word: String) -> String:
	
	if (p_second_word == ""):
		return Types.wrap_system_text("Go Where?")
		
	if current_room.exits.keys().has(p_second_word):
		var exit = current_room.exits[p_second_word]
		if exit.is_locked:
			return "The way to the " + Types.wrap_location_text(p_second_word) + " is currently " +  Types.wrap_system_text("locked")
		var change_response = change_room(exit.get_other_room(current_room))
		return PoolStringArray([
			"You went %s" %Types.wrap_system_text(p_second_word), change_response
		]).join("\n")
	
	else:
		return Types.wrap_system_text("The room has no exit in that direction")
		
	
func help() -> String:
	return "You can use these commands: go [location], help, take [item], inventory, drop [item]"
	
	
func change_room(p_new_room: GameRoom) -> String:
	current_room = p_new_room
	emit_signal("room_changed", p_new_room)
	return p_new_room.get_full_description()
