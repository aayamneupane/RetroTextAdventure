extends PanelContainer

const INPUT_RESPONSE = preload("res://input/input_response.tscn")

onready var scroll_container = $ScrollContainer

onready var history_rows = $ScrollContainer/history_rows

var max_scroll_length := 0

var should_zebra:= false

export (int) var max_lines = 30 #(int) is a typehit that helps guide the user input value to set type hit data type

onready var scroll_bar = scroll_container.get_v_scrollbar()



func _ready() -> void:
	scroll_bar.connect("changed", self, "_on_scrollbar_changed")
	max_scroll_length = scroll_bar.max_value


### Public Functions Below ###

func create_response(p_response_text: String):
	var response = INPUT_RESPONSE.instance()
	_add_response_to_game(response)
	response.set_text(p_response_text)
	
	
func create_response_with_input(p_response_text: String, p_input_text: String) -> void:
	var input_response = INPUT_RESPONSE.instance()
	_add_response_to_game(input_response)
	input_response.set_text(p_response_text, p_input_text)

### Pivate Functions Below ###

func _on_scrollbar_changed() -> void:
	if (max_scroll_length != scroll_bar.max_value):
		max_scroll_length = scroll_bar.max_value
		scroll_container.scroll_vertical = max_scroll_length
		
		
func _del_input_rows() -> void:
	if (history_rows.get_child_count() > max_lines):
		var rows_to_delete :int = history_rows.get_child_count() - max_lines
		for i in range(rows_to_delete):
			history_rows.get_child(i).queue_free() 
			
			
func _add_response_to_game(response: Control):
	history_rows.add_child(response)
	if not should_zebra:
		response.zebra.hide()
	should_zebra = !should_zebra
	_del_input_rows()
	
