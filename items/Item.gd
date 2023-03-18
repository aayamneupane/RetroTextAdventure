extends Resource

class_name Item

export (String) var item_name = "Item Name"

export (Types.ItemTypes) var item_type = Types.ItemTypes.KEY

var use_value = null

func initialize(p_item_name: String, p_item_type: int):
	self.item_name = p_item_name
	self.item_type = p_item_type

