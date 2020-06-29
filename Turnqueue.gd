extends Control

class_name TurnQueue

onready var active_character

func _ready():
	initialize()

func initialize():
	var mobs = get_mobs()
	mobs.sort_custom(self, "sort_mobs")
	for mob in mobs:
		mob.raise()
	active_character = get_child(0)
	active_character.play_turn()

static func sort_mobs(a, b):
	return a.speed > b.speed

func play_turn():
	yield(active_character, "completed")
	var new_index : int = (active_character.get_index() + 1) % get_child_count()
	active_character = get_child(new_index)
	active_character.play_turn()

func get_mobs():
	return get_children()
