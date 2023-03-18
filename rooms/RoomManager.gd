extends Node

var exit


func _ready() -> void:
	
#	key.initialize("Key", Types.ItemTypes.KEY)
	$ShedRoom.connect_exit_unlocked("west", $BackOfInn)
	$BackOfInn.connect_exit_unlocked("path", $VillageSquare)
	
	$VillageSquare.connect_exit_unlocked("north", $TownsGate)
	$VillageSquare.connect_exit_unlocked("west", $Field)
	$VillageSquare.connect_exit_unlocked("east", $InnDoor)
	
	var sword = load_item("GuardSword")
	$Field.add_item(sword)
	
	$InnDoor.connect_exit_unlocked("inside", $Inn)
	var inn_keeper = load_npc("innkeeper")
	$Inn.add_npc(inn_keeper)
	$Inn.connect_exit_unlocked("south", $InnKitchen)
#	$Inn.connect_exit_unlocked("west", $InnDoor)
	
	var key = load_item("InnKitchenKey")
	$InnKitchen.add_item(key)
	exit = $InnKitchen.connect_exit_locked("south", $BackOfInn)
	key.use_value = exit
#	key.use_value = $BackOfInn
	
	var guard = load_npc("Guard")
	$TownsGate.add_npc(guard)
	exit = $TownsGate.connect_exit_locked("forest", $Forest, "gate")
	guard.quest_reward = exit
	
func load_item(p_item_name: String):
	return load("res://items/" + p_item_name + ".tres")
	
func load_npc(p_npc_name: String):
	return load("res://NPCs/" + p_npc_name + ".tres")

