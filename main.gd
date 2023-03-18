extends Control



onready var command_processor = $CommandProcessor
onready var room_manager = $RoomManager
onready var player = $Player
onready var game_info = $Background/margin_container/Columns/rows/GameInfo


func _ready() -> void:
	var side_panel_path = $Background/margin_container/Columns/SidePanel
	command_processor.connect("room_changed", side_panel_path, "on_room_changed")
	command_processor.connect("room_updated", side_panel_path, "on_room_updated")
	game_info.create_response(Types.wrap_system_text("Welcome to Retro Text Adventure! You can type help to view commands"))
	var starting_room_response = command_processor.initialize(room_manager.get_child(0), player)
	game_info.create_response(starting_room_response)

func _on_input_text_text_entered(new_text: String) -> void:
	var response_message = command_processor.process_command(new_text)
	game_info.create_response_with_input(response_message, new_text)

