extends Control


const path = MonsterDb.MONSTER
var active_selection := 1
var death := false

signal completed
# warning-ignore:unused_signal
signal stop_waiting

var lvl = 0

onready var base_hp := 0
onready var max_hp := base_hp
onready var base_lvl_hp := 0
onready var hp := base_hp setget set_health
onready var lvl_hp := base_lvl_hp

onready var max_mana := 100
onready var mana := max_mana setget set_mana
onready var base_mana_regen := 0
onready var mana_regen := base_mana_regen

onready var base_speed := 0
onready var speed := base_speed
onready var base_lvl_speed := 0
onready var lvl_speed := base_lvl_speed

onready var base_atk := 0
onready var atk := base_atk
onready var base_lvl_atk := 0
onready var lvl_atk := base_lvl_atk

onready var base_def := 0
onready var def := base_def
onready var base_lvl_def := 0
onready var lvl_def := base_lvl_def

var chosen = null
var go_monster

func _ready():
	randomize()
# warning-ignore:return_value_discarded
	self.connect("gui_input", self, "_on_Input")
	var monster = Global.Char1
	go_monster = MonsterDb.get_monster(monster)
	var launch_monster = load(go_monster.icon)
	$"Enn1/E1/En1".texture = launch_monster

	lvl = randi() % 19 * Global.wave + 1
	$Lvl1.text = str(lvl)

	base_hp = int(go_monster["base_hp"]) + base_hp
	base_lvl_hp = int(go_monster["base_lvl_hp"]) + base_lvl_hp
	lvl_hp = base_lvl_hp * lvl
	max_hp = base_hp + lvl_hp
	hp = max_hp
	
	base_mana_regen = int(go_monster["base_mana_regen"]) + base_mana_regen
	mana_regen = base_mana_regen + mana_regen
	
	base_speed = int(go_monster["base_speed"]) + base_speed
	base_lvl_speed = int(go_monster["base_lvl_speed"]) + base_lvl_speed
	lvl_speed = base_lvl_speed * lvl
	speed = base_speed + lvl_speed
	
	base_atk = int(go_monster["base_atk"]) + base_atk
	base_lvl_atk = int(go_monster["base_lvl_atk"]) + base_lvl_atk
	lvl_atk = base_lvl_atk * lvl
	atk = base_atk + lvl_atk

	base_def = int(go_monster["base_def"]) + base_def
	base_lvl_def = int(go_monster["base_lvl_def"]) + base_lvl_def
	lvl_def = base_lvl_def * lvl
	def = base_def + lvl_def

	$HpText.text = str(hp,"/", max_hp)
	$Hp1.value = int((float(hp) / max_hp) * 100)
	$Mana1.value = int((float(mana) / max_mana) * 100)


func set_health(new_health):
	if hp != new_health:
		hp = new_health
		$Hp1.value = int((float(hp) / max_hp) * 100)
		$HpText.text = str(hp,"/", max_hp)
	if hp <= 0:
		$'Char1/C1/1'.texture = null
		$Hp1.value = int((float(hp) / max_hp) * 0)

func set_mana(new_mana):
	if mana != new_mana:
		mana = new_mana
		$Mana1.value = int((float(mana) / max_mana) * 100)
	#includes spell if enough mana, gray icon if can't launch it

signal chosed

func _on_Input(event):
	if event is InputEventMouseButton:
		if event.is_action_pressed("l_click"):
			if active_selection != 0:
				sprite()
				yield($"../../Ennemy", "stop_waiting")
				emit_signal("chosed")
				active_selection = 0
				yield($"../../Ennemy", "target_reached")
				print(hp)
				hp -= Global.damage
				print(hp)


func sprite():
	$'../../Ennemy/Icon'.texture = load(go_monster.sprite)
	$"../../Ennemy".velocity = Vector2(-1000, 0)

func play_turn():
	if mana >= 20:
		print("spell")
		$"..".play_turn()
		emit_signal("completed")
