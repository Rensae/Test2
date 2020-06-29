extends Control


const menu = preload("res://ActionMenu.tscn")
const projectile = preload("res://Projectile.tscn")

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

var go_monster
signal completed

func _ready():
	$"Lvl1".text = str(Global.lvl1)
	var lvl = Global.lvl1
	var monster = Global.Char1
	go_monster = MonsterDb.get_monster(monster)
	var launch_monster = load(go_monster.icon)
	$"Char1/C1/Ch1".texture = launch_monster

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

	$Hp1.value = int((float(hp) / max_hp) * 100)
	$Mana1.value = int((float(mana) / max_mana) * 100)

func set_health(new_health):
	if hp != new_health:
		hp = new_health
	if hp <= 0:
		$'Char1/C1/1'.texture = null

func set_mana(new_mana):
	if mana != new_mana:
		mana = new_mana
	#includes spell if enough mana, gray icon if can't launch it

func play_turn():
	sprite()
	var action = menu.instance()
	add_child(action)
	action.rect_position = Vector2(300, -285)
	yield(action, "finished")
	var new_projectile = projectile.instance()
	add_child(new_projectile)
	new_projectile.position = Vector2(200, -285)
	new_projectile.scale = Vector2(0.2, 0.2)
	new_projectile.velocity = Vector2(800, 0)
	Global.damage = atk
	yield($"../../Ennemy", "target_reached")
	new_projectile.queue_free()

func sprite():
	$'../../Character/Icon'.texture = load(go_monster.sprite)
	$"../../Character".velocity = Vector2(1000, 0)
