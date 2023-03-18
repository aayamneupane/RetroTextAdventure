
extends Node


var inventory: Array = []

func pickup_item(p_item: Item):
	inventory.append(p_item)


func get_inventory_list() -> String:
	
	if inventory.size() == 0:
		return "You dont have any items in the inventory"
		
	var item_string = ""
	for item in inventory:
		item_string += item.item_name + ""
	return "Inventory: " + item_string
	
func drop_item(p_item: Item):
	inventory.erase(p_item)
