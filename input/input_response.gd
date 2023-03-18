extends MarginContainer

onready var input_label = $Rows/input_history
onready var response_label = $Rows/response_history
onready var zebra = $Zebra


#var input_text: String
#var response_text: String

func _ready() -> void:
	pass
	
func set_text(p_response: String, p_input: String = "") -> void:
	if p_input == "":
		input_label.queue_free()
	else:
		input_label.text = " > " + p_input
	response_label.bbcode_text = p_response
