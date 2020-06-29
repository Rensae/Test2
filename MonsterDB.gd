extends Node

const MONSTER_PATH = "res://Character/"
const ICON_PATH = "res://Portrait/"
const MONSTER = {
	"Tenshi": {
		"sprite": MONSTER_PATH + "image00.jpg",
		"icon": ICON_PATH + "image0.jpg",
		"base_hp": 20,
		"base_lvl_hp": 2,
		"base_mana_regen": 2,
		"base_speed": 2,
		"base_lvl_speed": 2,
		"base_atk": 2,
		"base_lvl_atk": 2,
		"base_def": 2,
		"base_lvl_def": 2
		}
	}

func get_monster(monster_id):
	if monster_id in MONSTER:
		return MONSTER[monster_id]
	else:
		return null
