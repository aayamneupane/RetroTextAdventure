extends Node


enum ItemTypes {
	KEY,
	QUEST_ITEM,
}

const COLOR_NPC = Color("#ff9a94")
const COLOR_ITEM = Color("#94b9ff")
const COLOR_SPEECH = Color("#c3ff94")
const COLOR_LOCATION = Color("#faff94")
const COLOR_SYSTEM = Color("#ffd394")


func wrap_system_text(p_text: String) -> String:
	return "[color=#%s]%s[/color]" %[COLOR_SYSTEM.to_html(), p_text ]
	
func wrap_location_text(p_text: String) -> String:
	return "[color=#%s]%s[/color]" %[COLOR_LOCATION.to_html(), p_text ]
	
func wrap_speech_text(p_text: String) -> String:
	return "[color=#%s]%s[/color]" %[COLOR_SPEECH.to_html(), p_text ]
	
func wrap_item_text(p_text: String) -> String:
	return "[color=#%s]%s[/color]" %[COLOR_ITEM.to_html(), p_text ]
	
func wrap_npc_text(p_text: String) -> String:
	return "[color=#%s]%s[/color]" %[COLOR_NPC.to_html(), p_text ]
